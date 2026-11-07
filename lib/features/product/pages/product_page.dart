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
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. HEADER
          Container(
            width: double.infinity,
            color: AppColors.green,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
             // tombol back
                Positioned(
                  left: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                // Judul (Tengah)
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

          // 2. SEARCH BAR
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

          // 3. GRID PRODUK
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
                
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent, 
                      builder: (context) {
                        return Container(
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
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}