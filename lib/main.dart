import 'package:flutter/material.dart';

import 'features/auth/login.dart';

// 1. Uncomment (hapus garis miring) import ini jika file artikel_event_page.dart sudah kamu buat:
// import 'views/artikel_event_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Sampah Sahabat Ibu',
      theme: ThemeData(
        // Perbaikan penulisan ColorScheme
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      // Aplikasi akan langsung memuat LoginPage saat pertama kali dibuka
      home: const LoginPage(),
    );
  }
}

// =====================================================================
// CONTOH HALAMAN BERANDA (Tempat menaruh tombol Artikel & Event)
// =====================================================================

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // Perbaikan penulisan MainAxisAlignment
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat datang di Bank Sampah!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // 2. DI SINILAH TEMPAT MENARUH TOMBOL DAN NAVIGATOR.PUSH
            ElevatedButton(
              onPressed: () {
                // Hapus tanda komentar (//) di bawah ini untuk mengaktifkan perpindahan halaman

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const ArtikelEventPage(),
                //   ),
                // );
              },
              child: const Text('Buka Halaman Artikel & Event'),
            ),
          ],
        ),
      ),
    );
  }
}
