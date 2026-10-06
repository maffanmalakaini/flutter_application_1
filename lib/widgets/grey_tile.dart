import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/widgets/reveal.dart';

class GreyTile extends StatelessWidget {
  final String left, right;
  final int i;
  const GreyTile(this.left, this.right, this.i, {super.key});
  @override
  Widget build(BuildContext c) => Reveal(
        delay: i * 90,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: kTile,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 3))],
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(left, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black54)),
            Text(right, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ]),
        ),
      );
}
