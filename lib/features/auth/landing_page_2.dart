import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import 'welcome_page.dart';

class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFA8F0BC)],
            stops: [0.45, 0.9],
          ),
        ),
        child: Column(
          children: [
            // --- BAGIAN ATAS: TEKS & TOMBOL ---
            Expanded(
              flex: 0, 
              child: SafeArea(
                bottom: false, 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () => Navigator.pop(context),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WelcomePage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              "Selanjutnya",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Judul
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Setiap Sampah\n",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                height: 1.2,
                              ),
                            ),
                            TextSpan(
                              text: "Punya Nilai",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Deskripsi
                      const Text(
                        "Ubah sampah menjadi sumber penghasilan tambahan. Kumpulkan sampah yang masih bernilai jual dan tukarkan langsung menjadi saldo.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Tombol Kanan
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildFeatureCard(
                          context,
                          title: "Kenali Jenis Sampah",
                          subtitle: "Foto & Analisis AI",
                          color: const Color(0xFF54D978),
                          width: size.width * 0.65,
                        ),
                      ),
                      const SizedBox(height: 10),
                      
                      // Tombol Kiri
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _buildFeatureCard(
                          context,
                          title: "Setor Sampah Anda",
                          subtitle: "Foto & Analisis AI",
                          color: const Color(0xFF7DE89B),
                          width: size.width * 0.65,
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Judul Analisis AI
                      const Text(
                        "Analisis AI",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Ambil foto sampahmu untuk mendeteksi dan mengetahui jenisnya dengan bantuan teknologi cerdas.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16), 
                    ],
                  ),
                ),
              ),
            ),

            // --- BAGIAN BAWAH: GAMBAR TANGAN & HP ---
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  alignment: Alignment.bottomLeft, 
                  child: Transform.translate(
                    offset: const Offset(0, 55), 
                    child: Image.asset(
                      'assets/images/LandingPage2.png',
                      width: size.width * 1.3, 
                      fit: BoxFit.fitWidth, 
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_outward,
              color: color,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}