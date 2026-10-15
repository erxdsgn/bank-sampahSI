import 'package:flutter/material.dart';
import 'home_menu_item.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HomeMenuItem(
            assetName: 'assets/icons/setor_sampah.png',
            label: 'Setor\nSampah',
            onTap: () => _onTap(context, 'Setor Sampah'),
          ),
        ),
        Expanded(
          child: HomeMenuItem(
            assetName: 'assets/icons/produk_daur_ulang.png',
            label: 'Produk\nDaur Ulang',
            onTap: () => _onTap(context, 'Produk Daur Ulang'),
          ),
        ),
        Expanded(
          child: HomeMenuItem(
            assetName: 'assets/icons/harga_sampah.png',
            label: 'Harga\nSampah',
            onTap: () => _onTap(context, 'Harga Sampah'),
          ),
        ),
        Expanded(
          child: HomeMenuItem(
            assetName: 'assets/icons/jadwal_lokasi.png',
            label: 'Jadwal &\nLokasi',
            onTap: () => _onTap(context, 'Jadwal & Lokasi'),
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context, String name) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$name ditekan')));
  }
}