import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../views/artikel_event_page.dart';

/// Halaman utama dengan bottom navbar: Beranda, Produk, Riwayat, Profile.
/// Dipanggil setelah login berhasil:
/// Navigator.pushReplacement(
///   context, MaterialPageRoute(builder: (_) => const MainNavigation()));
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Semua tab sekarang menggunakan halaman polos (_EmptyPage), kecuali HomeTab
  final List<Widget> _pages = const [
    HomeTab(),
    ProdukTab(),
    RiwayatTab(),
    ProfileTab(),
  ];

  // Data item navbar (ikon + label).
  static const _items = [
    _NavItemData(icon: Icons.home_outlined, label: 'Beranda'),
    _NavItemData(icon: Icons.shopping_cart_outlined, label: 'Produk'),
    _NavItemData(icon: Icons.description_outlined, label: 'Riwayat'),
    _NavItemData(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // IndexedStack menjaga state tiap tab saat berpindah.
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _BottomNavBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  const _NavItemData({required this.icon, required this.label});
}

/// Bottom navbar buatan sendiri, tiap item memakai InkWell.
class _BottomNavBar extends StatelessWidget {
  final List<_NavItemData> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      // SafeArea supaya tidak tertutup home indicator / tombol sistem
      child: SafeArea(
        top: false,
        // Material dibutuhkan agar efek ripple InkWell terlihat
        child: Material(
          color: AppColors.white,
          child: Row(
            children: [
              for (int i = 0; i < items.length; i++)
                Expanded(
                  child: _NavItem(
                    data: items[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _NavItemData data;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.green : AppColors.textDark;

    return InkWell(
      onTap: onTap,
      splashColor: AppColors.green.withOpacity(0.15),
      highlightColor: AppColors.green.withOpacity(0.08),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data.icon, size: 28, color: color),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Halaman polos dengan judul di tengah.
class _EmptyPage extends StatelessWidget {
  final String title;
  const _EmptyPage(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// =========================================================
// WIDGET TAB HALAMAN
// =========================================================

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ini Halaman Beranda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            // Tombol untuk memanggil halaman event
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArtikelEventPage(),
                  ),
                );
              },
              child: const Text(
                'Lihat Artikel & Event',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProdukTab extends StatelessWidget {
  const ProdukTab({super.key});

  @override
  Widget build(BuildContext context) => const _EmptyPage('Produk');
}

class RiwayatTab extends StatelessWidget {
  const RiwayatTab({super.key});

  @override
  Widget build(BuildContext context) => const _EmptyPage('Riwayat');
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) => const _EmptyPage('Profile');
}
