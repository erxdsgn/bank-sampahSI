import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          
          //header
          Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.green,
            ),
          ),

          
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Judul Profile
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                 
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 150,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),

                      // isi profile
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF1F1F1),
                                  border: Border.all(color: Colors.white, width: 4),
                                  // image: const DecorationImage(
                                  //   image: AssetImage('assets/images/avatar_default.png'),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                child: const Icon(Icons.person, size: 60, color: AppColors.muted),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          // Nama User
                          const Text(
                            "Erix Agung Wibowo",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          
                          // Kelompok
                          const Text(
                            "Kelompok A (Perumahan)",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // List Menu
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Akun",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.muted),
                                ),
                                const SizedBox(height: 8),
                                _MenuCard(
                                  icon: Icons.person_outline,
                                  title: "Informasi Pribadi",
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.personalInfo);
                                  },
                                ),
                                _MenuCard(
                                  icon: Icons.lock_outline,
                                  title: "Password",
                                  onTap: () {},
                                ),
                                _MenuCard(
                                  icon: Icons.notifications_none,
                                  title: "Notifikasi",
                                  trailing: Switch(
                                    value: true,
                                    onChanged: (val) {},
                                    activeColor: AppColors.green,
                                  ),
                                  onTap: () {},
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Preferensi",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.muted),
                                ),
                                const SizedBox(height: 8),
                                _MenuCard(
                                  icon: Icons.info_outline,
                                  title: "Tentang Kami",
                                  onTap: () {},
                                ),
                                _MenuCard(
                                  icon: Icons.help_outline,
                                  title: "Bantuan",
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRoutes.helpCenter);
                                  },
                                ),
                                const SizedBox(height: 100),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk List Menu
  Widget _MenuCard({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.textDark, size: 22),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.muted, size: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}