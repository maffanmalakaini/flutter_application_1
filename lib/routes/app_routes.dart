import 'package:flutter/material.dart';
import 'package:rumah_sehat/screens/auth/login_screen.dart';
import 'package:rumah_sehat/screens/auth/register_screen.dart';
import 'package:rumah_sehat/screens/booking_screen.dart';
import 'package:rumah_sehat/screens/main_navigation.dart';
import 'package:rumah_sehat/screens/resep_screen.dart';
import 'package:rumah_sehat/services/api_service.dart';
import 'package:rumah_sehat/screens/igd_screen.dart';
import 'package:rumah_sehat/screens/info_bed_screen.dart';
import 'package:rumah_sehat/screens/info_poli_screen.dart';
import 'package:rumah_sehat/screens/soon_screen.dart';
import 'package:rumah_sehat/screens/tentang_screen.dart';

class AppRoutes {
  static Route<dynamic> generate(RouteSettings s) {
    final pages = <String, Widget>{
      '/login': const LoginScreen(),
      '/register': const RegisterScreen(),
      '/home': MainNavigation(userData: ApiService.user),
      '/resep': const ResepScreen(),
      '/booking': const BookingScreen(),
      '/poli': const InfoPoliScreen(),
      '/igd': const IgdScreen(),
      '/bed': const InfoBedScreen(),
      '/tentang': const TentangScreen(),
    };
    final page = pages[s.name] ?? const SoonScreen();
    return PageRouteBuilder(
      settings: s,
      transitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, a, __, child) {
        final curve = CurvedAnimation(parent: a, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curve,
          child: SlideTransition(
            position: Tween(begin: const Offset(.08, 0), end: Offset.zero).animate(curve),
            child: child,
          ),
        );
      },
    );
  }
}
