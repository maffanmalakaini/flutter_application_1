import 'package:flutter/material.dart';

/// Animasi fade + slide naik dengan delay (untuk efek muncul berurutan).
class Reveal extends StatefulWidget {
  final int delay;
  final Widget child;
  const Reveal({super.key, this.delay = 0, required this.child});
  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) => FadeTransition(
        opacity: CurvedAnimation(parent: _c, curve: Curves.easeOut),
        child: SlideTransition(
          position: Tween(begin: const Offset(0, .25), end: Offset.zero)
              .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic)),
          child: widget.child,
        ),
      );
}
