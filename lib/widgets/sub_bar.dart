import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';

PreferredSizeWidget subBar(IconData icon, String title) => AppBar(
      backgroundColor: kBlue,
      foregroundColor: Colors.white,
      toolbarHeight: 72,
      titleSpacing: 0,
      title: Row(children: [
        Icon(icon, size: 34),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
      ]),
    );
