import 'package:flutter/material.dart';
import 'package:rumah_sehat/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext c) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8DB8F2), Colors.white, Color(0xFF8DB8F2)],
            ),
          ),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: .5, end: 1),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutBack,
              builder: (_, v, child) => Opacity(
                opacity: v.clamp(0, 1),
                child: Transform.scale(scale: v, child: child),
              ),
              child: const Hero(tag: 'logo', child: Material(color: Colors.transparent, child: Logo(size: 80))),
            ),
          ),
        ),
      );
}
