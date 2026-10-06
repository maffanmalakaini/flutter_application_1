import 'package:flutter/material.dart';
import 'package:rumah_sehat/widgets/sub_bar.dart';

class SoonScreen extends StatelessWidget {
  const SoonScreen({super.key});
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: subBar(Icons.construction, 'Segera Hadir'),
        body: const Center(child: Text('Halaman ini belum tersedia')),
      );
}
