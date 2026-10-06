import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/widgets/reveal.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic>? userData;
  const HomeScreen({super.key, this.userData});
  static const menu = [
    ('Info Poli', Icons.local_hospital_outlined, '/poli'),
    ('Resep Obat', Icons.medication_outlined, '/resep'),
    ('IGD', Icons.emergency, '/igd'),
    ('Atur Jadwal', Icons.edit_calendar, '/booking'),
    ('Info Bed', Icons.bed, '/bed'),
    ('Tentang Kami', Icons.apartment, '/tentang'),
  ];
  @override
  Widget build(BuildContext c) => Scaffold(
        body: Column(children: [
          Container(
            width: double.infinity,
            color: kBlue,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SafeArea(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 12),
                const Reveal(child: Text('Selamat Datang,', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
                Reveal(delay: 100, child: Text('Hi, ${(userData?['name'] ?? 'Pengguna').toString().split(' ').first}', style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800))),
                const SizedBox(height: 4),
                const Text('Silahkan pilih cabang Rumah Sehat terlebih dahulu', style: TextStyle(color: Colors.white, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    value: 'RUMAH SEHAT, JAKARTA PUSAT',
                    style: const TextStyle(color: kBlue, fontWeight: FontWeight.w800),
                    items: const [DropdownMenuItem(value: 'RUMAH SEHAT, JAKARTA PUSAT', child: Text('RUMAH SEHAT, JAKARTA PUSAT'))],
                    onChanged: (_) {},
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 24, childAspectRatio: .95),
              itemCount: menu.length,
              itemBuilder: (_, i) {
                final m = menu[i];
                return Reveal(
                  delay: 150 + i * 80,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Navigator.pushNamed(c, m.$3),
                    child: Column(children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
                          ),
                          child: Icon(m.$2, color: kBlue, size: 60),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(m.$1, style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black54)),
                    ]),
                  ),
                );
              },
            ),
          ),
        ]),
      );
}
