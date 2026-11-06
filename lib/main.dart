import 'package:flutter/material.dart';
import 'features/auth/landing_page_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Sampah Sahabat Ibu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF22C55E)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const LandingPage1(),
    );
  }
}