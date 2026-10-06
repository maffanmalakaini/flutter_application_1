import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';

/// Ganti Icon ini dengan Image.asset('assets/logo.png') kalau sudah punya file logo.
class Logo extends StatelessWidget {
  final double size;
  final bool text;
  const Logo({super.key, this.size = 64, this.text = true});
  @override
  Widget build(BuildContext c) => Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.local_hospital_rounded, color: kBlue, size: size),
        if (text)
          const Text('RUMAH SEHAT MOBILE',
              style: TextStyle(color: kBlue, fontWeight: FontWeight.w800, fontSize: 13)),
      ]);
}
