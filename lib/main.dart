import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'core/constants/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(child: Text('Bank Sampah Sahabat Ibu')),
      ),
    );
  }
}