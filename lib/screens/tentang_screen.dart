import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/widgets/logo.dart';
import 'package:rumah_sehat/widgets/reveal.dart';
import 'package:rumah_sehat/widgets/sub_bar.dart';

class TentangScreen extends StatefulWidget {
  const TentangScreen({super.key});
  @override
  State<TentangScreen> createState() => _TentangState();
}

class _TentangState extends State<TentangScreen> {
  int _p = 0;
  @override
  Widget build(BuildContext c) {
    const rows = [
      ('Nama Cabang', 'Rumah Sehat Jakpus'),
      ('Alamat', 'Jl. Gatot Subroto XI, Jakarta Pusat'),
      ('Email', 'rsehatjakpus@rsh.com'),
      ('Kelas', 'A'),
      ('Akreditasi', 'Paripurna – LARS DHP'),
    ];
    return Scaffold(
      appBar: subBar(Icons.apartment, 'Tentang Kami'),
      body: ListView(children: [
        SizedBox(
          height: 225,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            PageView.builder(
              itemCount: 5,
              onPageChanged: (i) => setState(() => _p = i),
              // Ganti dengan Image.asset foto gedung.
              itemBuilder: (_, i) => Container(color: Color.lerp(kBlue, Colors.blueGrey, i / 5), child: const Icon(Icons.apartment, color: Colors.white54, size: 90)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                for (var i = 0; i < 5; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.all(3),
                    width: i == _p ? 16 : 7,
                    height: 7,
                    decoration: BoxDecoration(color: i == _p ? Colors.white : Colors.white54, borderRadius: BorderRadius.circular(4)),
                  ),
              ]),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        const Center(child: Logo(size: 60, text: false)),
        const Center(child: Text('RUMAH SEHAT', style: TextStyle(color: kBlue, fontWeight: FontWeight.w800))),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            for (final (i, r) in rows.indexed)
              Reveal(
                delay: i * 90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    SizedBox(width: 120, child: Text(r.$1, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                    const Text(': ', style: TextStyle(color: Colors.black54, fontSize: 16)),
                    Expanded(child: Text(r.$2, style: const TextStyle(color: Colors.black54, fontSize: 16))),
                  ]),
                ),
              ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Lihat Sertifikat Akreditasi', style: TextStyle(color: kBlue, fontSize: 16, decoration: TextDecoration.underline)),
            ),
          ]),
        ),
      ]),
    );
  }
}
