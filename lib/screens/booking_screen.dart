import 'package:flutter/material.dart';
import '../services/api_service.dart';

/// CLASS: BookingScreen untuk memilih Poli & Tanggal Pendaftaran
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String? _selectedPoli;
  final TextEditingController _tanggalController = TextEditingController();
  bool _isLoading = false;

  final List<String> _poliList = [
    'Poli Umum',
    'Poli Anak',
    'Poli Kandungan',
    'Poli Gigi',
    'Poli Mata',
  ];

  /// METHOD: Memilih Tanggal
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  /// METHOD: Mengirim Form Pendaftaran ke API
  Future<void> _submitBooking() async {
    if (_selectedPoli == null || _tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap pilih Poli dan Tanggal!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await ApiService.createTransaksi(
      _selectedPoli!,
      _tanggalController.text,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran Berhasil!')),
      );
      Navigator.pop(context); // Kembali ke Home
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat pendaftaran.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Atur Jadwal / Booking', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown Pilihan Poli
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pilih Poli Target',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.medical_services_outlined),
              ),
              value: _selectedPoli,
              items: _poliList.map((poli) {
                return DropdownMenuItem(value: poli, child: Text(poli));
              }).toList(),
              onChanged: (val) => setState(() => _selectedPoli = val),
            ),
            const SizedBox(height: 16),

            // Field Tanggal
            TextField(
              controller: _tanggalController,
              readOnly: true,
              onTap: _selectDate,
              decoration: const InputDecoration(
                labelText: 'Pilih Tanggal Berobat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today_outlined),
              ),
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            ElevatedButton(
              onPressed: _isLoading ? null : _submitBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'DAFTAR SEKARANG',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}