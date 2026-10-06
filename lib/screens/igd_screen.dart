import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/widgets/reveal.dart';
import 'package:rumah_sehat/widgets/sub_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// Ganti dengan nomor IGD yang sebenarnya.
const kIgdTelepon = '027422';
const kIgdWhatsApp = '6281234567890'; // format internasional, tanpa tanda +

class IgdScreen extends StatelessWidget {
  const IgdScreen({super.key});

  Future<void> _buka(BuildContext c, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication).catchError((_) => false);
    if (!ok && c.mounted) {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka aplikasi')),
      );
    }
  }

  @override
  Widget build(BuildContext c) {
    final tombol = [
      ('Hubungi Via Telepon', Uri(scheme: 'tel', path: kIgdTelepon)),
      (
        'Hubungi Via WhatsApp',
        Uri.https('wa.me', '/$kIgdWhatsApp', {'text': 'Halo, saya membutuhkan bantuan IGD Rumah Sehat.'})
      ),
    ];
    return Scaffold(
      appBar: subBar(Icons.emergency, 'IGD'),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 250,
          width: double.infinity,
          color: kTile,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(16),
          child: const Row(children: [
            Icon(Icons.map_outlined, color: Colors.black38, size: 30),
            SizedBox(width: 6),
            Text('Google Maps', style: TextStyle(color: Colors.black38, fontSize: 20, fontWeight: FontWeight.w800)),
          ]),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text('Rumah Sehat, Jakarta Pusat\n$kIgdTelepon', style: TextStyle(color: Colors.black54, fontSize: 16)),
        ),
        for (final (i, t) in tombol.indexed)
          Reveal(
            delay: i * 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: kTile,
                    foregroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _buka(c, t.$2),
                  child: Text(t.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}