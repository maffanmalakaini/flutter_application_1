import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/services/api_service.dart';

class BottomBar extends StatelessWidget {
  final int index;
  const BottomBar(this.index, {super.key});
  @override
  Widget build(BuildContext c) {
    Widget item(int i, IconData ic, String? route) => IconButton(
          iconSize: 34,
          color: i == index ? kBlue : Colors.black87,
          icon: Icon(ic),
          onPressed: () {
            if (i == index) return;
            if (route == null) {
              ApiService.logout().then((_) {
                if (c.mounted) Navigator.pushReplacementNamed(c, '/login');
              }); // Profil: logout
            } else {
              Navigator.pushReplacementNamed(c, route);
            }
          },
        );
    return Container(
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black12))),
      child: SafeArea(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          item(0, Icons.receipt_long, '/transaksi'),
          item(1, Icons.local_hospital_rounded, '/home'),
          item(2, Icons.person, null),
        ]),
      ),
    );
  }
}
