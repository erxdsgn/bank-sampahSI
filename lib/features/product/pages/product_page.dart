import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart'; 

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    // Ambil data dari Provider
    final productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        // ═══ 1. HEADER HIJAU (AppBar Custom) ═══
        Container(
          width: double.infinity,
          color: AppColors.green,
          padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
          child: const Center(
            child: Text(
              "Produk Daur Ulang",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // ═══ 2. SEARCH BAR ═══
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cari Produk...",
              hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: AppColors.muted, size: 20),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.green),
              ),
            ),
          ),
        ),

        // ═══ 3. GRID PRODUK (2 KOLOM) ═══
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 Kolom
              crossAxisSpacing: 16, // Jarak antar kolom
              mainAxisSpacing: 16, // Jarak antar baris
              childAspectRatio: 0.75, // Rasio kotak produk
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              
              return GestureDetector(
                onTap: () {
                  // MENGGUNAKAN SHOW MODAL BOTTOM SHEET UNTUK POP-UP
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Agar pop-up bisa tinggi
                    backgroundColor: Colors.transparent, // Agar sudut melengkung terlihat
                    builder: (context) {
                      return Container(
                        // Tinggi pop-up 85% dari layar HP
                        height: MediaQuery.of(context).size.height * 0.85, 
                        child: ProductDetailPage(product: product),
                      );
                    },
                  );
                },
                child: ProductCard(
                  name: product.name,
                  price: product.price,
                  imagePath: product.imagePath,
                ),
              );
            },
          ),
        ),
        
        // Spasi di bawah agar tidak tertutup Bottom Navigation Bar
        const SizedBox(height: 80),
      ],
    );
  }
}