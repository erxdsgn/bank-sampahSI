import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../models/trash_price_model.dart';

class PricePage extends StatefulWidget {
  const PricePage({super.key});

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
// ganti dari api
  final List<TrashPrice> _prices = List.generate(
    15,
    (index) => TrashPrice(name: "Aluminium Kaleng", price: "Rp 20.000"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.green,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context, AppRoutes.home),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const Text(
                  "Harga Sampah",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.greenSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.info, color: AppColors.green, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Harga dapat berubah apabila terjadi kenaikan harga atau penyesuaian pengepul.",
                      style: TextStyle(fontSize: 11, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

         // list harga sampah
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _prices.length,
              separatorBuilder: (context, index) => Divider(
                color: AppColors.border.withOpacity(0.3),
                height: 1,
              ),
              itemBuilder: (context, index) {
                final item = _prices[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nama Sampah
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                      ),
                      
                      // Harga & Ikon
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.greenSurface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.price,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          
                          const Text(
                            "/kg",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
