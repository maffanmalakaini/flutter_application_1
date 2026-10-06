import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/services/api_service.dart';
import 'package:rumah_sehat/widgets/reveal.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});
  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  late Future<List<dynamic>> _future;

  static const _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
  static const _bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchTransaksi();
  }

  Future<void> _refresh() async {
    setState(() => _future = ApiService.fetchTransaksi());
    await _future.catchError((_) => <dynamic>[]);
  }

  /// "2026-06-24" -> "Rabu, 24 Juni 2026"
  String _tanggal(String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return iso;
    return '${_hari[d.weekday - 1]}, ${d.day.toString().padLeft(2, '0')} ${_bulan[d.month - 1]} ${d.year}';
  }

  (String, Color) _status(String s) => switch (s) {
        'berhasil' => ('Berhasil', const Color(0xFF2ECC57)),
        'dibatalkan' => ('Dibatalkan', const Color(0xFFFF3B3B)),
        _ => ('Proses', const Color(0xFF1E90FF)),
      };

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      backgroundColor: kBlue,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: kBlue,
        automaticallyImplyLeading: false,
        title: const Text('Transaksi', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24)),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          if (snap.hasError) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('Gagal memuat: ${snap.error}', style: const TextStyle(color: Colors.white)),
                TextButton(
                  onPressed: _refresh,
                  child: const Text('Coba lagi', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ]),
            );
          }
          final data = snap.data ?? [];
          if (data.isEmpty) {
            return const Center(child: Text('Belum ada transaksi', style: TextStyle(color: Colors.white, fontSize: 16)));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                for (final (i, d) in data.indexed)
                  Reveal(
                    delay: i * 110,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(d['poli'] ?? '', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 19, color: Colors.black54)),
                            Text(_tanggal(d['tanggal'] ?? ''), style: const TextStyle(color: Colors.black54, fontSize: 15)),
                          ]),
                        ),
                        Text(_status(d['status'] ?? '').$1,
                            style: TextStyle(color: _status(d['status'] ?? '').$2, fontWeight: FontWeight.w800, fontSize: 16)),
                      ]),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}