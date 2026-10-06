import 'package:flutter/material.dart';
import 'package:rumah_sehat/core/constants.dart';
import 'package:rumah_sehat/routes/app_routes.dart';
import 'package:rumah_sehat/screens/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rumah Sehat Mobile',
        theme: ThemeData(colorSchemeSeed: kBlue, useMaterial3: true),
        home: const SplashScreen(),
        onGenerateRoute: AppRoutes.generate,
      );
}
