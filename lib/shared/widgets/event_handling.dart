import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Handling')),

      // Semua isi ditumpuk ke bawah pakai Column
      body: Column(
        children: [

          // 1. TAP
          GestureDetector(
            onTap: () {
              print('Tap kepencet!');
            },
            child: Container(
              width: 200,
              height: 60,
              color: Colors.blue,
              child: const Center(child: Text('Tap Gue')),
            ),
          ),

          const SizedBox(height: 20),

          // 2. LONG PRESS (tahan lama)
          GestureDetector(
            onLongPress: () {
              print('Ditahan lama!');
            },
            child: Container(
              width: 200,
              height: 60,
              color: Colors.orange,
              child: const Center(child: Text('Tahan Gue')),
            ),
          ),

          const SizedBox(height: 20),

          // 3. TOMBOL
          ElevatedButton(
            onPressed: () {
              print('Tombol ditekan!');
            },
            child: const Text('Tekan Gue'),
          ),

          const SizedBox(height: 20),

          // 4. SCROLL (list panjang)
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                  onTap: () {
                    print('Item $index di-tap');
                  },
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}