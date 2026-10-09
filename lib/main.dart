import 'package:flutter/material.dart';
import 'core/themes/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'shared/widgets/event_handling.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EventPage(),
    );
  }
}