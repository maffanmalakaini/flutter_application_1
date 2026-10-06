import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiService {
  // Alamat otomatis: emulator Android = 10.0.2.2, selain itu 127.0.0.1.
  static String get baseUrl {
    if (kIsWeb) return 'http://127.0.0.1:8000/api';
    if (defaultTargetPlatform == TargetPlatform.android) return 'http://10.0.2.2:8000/api';
    return 'http://127.0.0.1:8000/api';
  }

  static String? token;
  static Map<String, dynamic>? user;

  static Future<dynamic> _request(String method, String path, [Map<String, dynamic>? body]) async {
    try {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };
      final uri = Uri.parse('$baseUrl$path');
      final req = method == 'GET'
          ? http.get(uri, headers: headers)
          : http.post(uri, headers: headers, body: jsonEncode(body ?? {}));
      final res = await req.timeout(const Duration(seconds: 10));
      final data = jsonDecode(res.body);
      if (res.statusCode >= 200 && res.statusCode < 300) return data;

      var msg = 'Terjadi kesalahan';
      if (data is Map) {
        msg = data['message']?.toString() ?? msg;
        if (data['errors'] is Map && (data['errors'] as Map).isNotEmpty) {
          msg = (data['errors'] as Map).values.first.first.toString();
        }
      }
      throw ApiException(msg);
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('Tidak bisa terhubung ke server');
    }
  }

  static Future<void> login(String email, String password) async {
    final data = await _request('POST', '/login', {'email': email, 'password': password});
    token = data['token'];
    user = data['user'];
  }

  static Future<void> register({
    required String name,
    required String email,
    required String noHp,
    required String password,
    required String confirm,
  }) async {
    final data = await _request('POST', '/register', {
      'name': name,
      'email': email,
      'no_hp': noHp,
      'password': password,
      'password_confirmation': confirm,
    });
    token = data['token'];
    user = data['user'];
  }

  static Future<void> logout() async {
    try {
      await _request('POST', '/logout');
    } catch (_) {
    } finally {
      token = null;
      user = null;
    }
  }

  /// Dipakai BookingScreen. tanggal format "d/m/yyyy" -> dikirim "yyyy-mm-dd".
  static Future<bool> createTransaksi(String poli, String tanggal) async {
    try {
      final p = tanggal.split('/');
      final iso = '${p[2]}-${p[1].padLeft(2, '0')}-${p[0].padLeft(2, '0')}';
      await _request('POST', '/transaksi', {'poli': poli, 'tanggal': iso});
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Dipakai TransaksiScreen: riwayat pendaftaran milik user yang login.
  static Future<List<dynamic>> fetchTransaksi() async {
    final data = await _request('GET', '/transaksi');
    return data as List<dynamic>;
  }

  /// Dipakai ResepScreen. Endpoint Laravel GET /api/resep akan kita buat nanti.
  static Future<List<dynamic>> fetchResep() async {
    final data = await _request('GET', '/resep');
    return data as List<dynamic>;
  }

  /// Dipakai InfoPoliScreen: [(nama poli, jam operasional)]
  static Future<List<(String, String)>> fetchPoli() async {
    final data = await _request('GET', '/poli') as List<dynamic>;
    return [for (final p in data) (p['nama'].toString(), '${p['jam_buka']}-${p['jam_tutup']}')];
  }

  /// Dipakai InfoBedScreen: [(nama ruang, jumlah bed)]
  static Future<List<(String, String)>> fetchBed() async {
    final data = await _request('GET', '/bed') as List<dynamic>;
    return [for (final b in data) (b['nama_ruang'].toString(), '${b['jumlah']} Bed')];
  }
}
