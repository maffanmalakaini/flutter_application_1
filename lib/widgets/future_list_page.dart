import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/widgets/grey_tile.dart';
import 'package:rumah_sehat/widgets/sub_bar.dart';

/// Halaman daftar (kiri-kanan) yang datanya dimuat dari API.
class FutureListPage extends StatefulWidget {
  final IconData icon;
  final String title;
  final Future<List<(String, String)>> Function() loader;
  const FutureListPage(this.icon, this.title, this.loader, {super.key});

  @override
  State<FutureListPage> createState() => _FutureListPageState();
}

class _FutureListPageState extends State<FutureListPage> {
  late Future<List<(String, String)>> _future = widget.loader();

  Future<void> _reload() async {
    setState(() => _future = widget.loader());
    await _future.catchError((_) => <(String, String)>[]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: subBar(widget.icon, widget.title),
        body: FutureBuilder<List<(String, String)>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: kBlue));
            }
            if (snap.hasError) {
              return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('Gagal memuat: ${snap.error}'),
                  TextButton(onPressed: _reload, child: const Text('Coba lagi')),
                ]),
              );
            }
            final items = snap.data ?? [];
            if (items.isEmpty) return const Center(child: Text('Data belum tersedia'));
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                children: [
                  for (var i = 0; i < items.length; i++) GreyTile(items[i].$1, items[i].$2, i),
                ],
              ),
            );
          },
        ),
      );
}