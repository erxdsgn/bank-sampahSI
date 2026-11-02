import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../../../../core/app_routes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data dari Provider
    final productProvider = Provider.of<ProductProvider>(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.green,
          padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
              left : 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
            const Text(
              "Produk Daur Ulang",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
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

        // grid produk 
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              crossAxisSpacing: 16, 
              mainAxisSpacing: 16, 
              childAspectRatio: 0.75, 
            ),
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return ProductCard(
                name: product.name,
                price: product.price,
                imagePath: product.imagePath,
              );
            },
          ),
        ),
        
        const SizedBox(height: 80),
      ],
    );
  }
}