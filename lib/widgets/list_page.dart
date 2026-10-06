import 'package:flutter/material.dart';
import 'package:rumah_sehat/widgets/sub_bar.dart';
import 'package:rumah_sehat/widgets/grey_tile.dart';

class ListPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<(String, String)> items;
  const ListPage(this.icon, this.title, this.items);
  @override
  Widget build(BuildContext c) => Scaffold(
        appBar: subBar(icon, title),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          for (var i = 0; i < items.length; i++) GreyTile(items[i].$1, items[i].$2, i),
        ]),
      );
}
