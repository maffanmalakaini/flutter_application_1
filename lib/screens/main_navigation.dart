import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'transaksi_screen.dart';
import 'profil_screen.dart';

/// CLASS: MainNavigation bertindak sebagai wadah Bottom Navigation Bar
class MainNavigation extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const MainNavigation({super.key, this.userData});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // PASSING USERDATA KE HOMESCREEN DI SINI:
    final List<Widget> pages = [
      HomeScreen(userData: widget.userData), // <-- PERBAIKAN: Tambahkan (userData: widget.userData) & hapus 'const'
      const TransaksiScreen(),
      ProfilScreen(userData: widget.userData),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF2196F3),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}