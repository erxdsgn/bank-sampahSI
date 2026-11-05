import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_colors.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  // Fungsi untuk membuka link
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Tidak bisa membuka link: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF38B54E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // AppBar Custom
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                "Pusat Bantuan",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                    
                   // bisa ganti
                    Container(
                      height: 160,
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: const Center(
                        child: Icon(Icons.support_agent, size: 100, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // isi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Semua Topik",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  _TopicCard(
                    icon: Icons.campaign_outlined,
                    title: "Ajukan Pengaduan",
                    subtitle: "Sampaikan kendala, pertanyaan, atau keluhan Anda",
                    onTap: () => _launchURL("https://wa.me/6282141055878?text=Halo%20Admin,%20saya%20ingin%20mengajukan%20pengaduan"),
                  ),
                  const SizedBox(height: 12),
                  
                  _TopicCard(
                    icon: Icons.info_outline,
                    title: "Tentang Bank Sampah Sahadat Ibu",
                    subtitle: "Seputar informasi dan pengetahuan yang sering ditanyakan mitra",
                    onTap: () {
                      //isi link navigasi
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

           // sosmed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hubungi Kami",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        _ContactItem(
                          icon: FontAwesomeIcons.whatsapp,
                          iconColor: const Color(0xFF25D366),
                          title: "WhatsApp",
                          subtitle: "+62 821-4105-5878",
                          onTap: () => _launchURL("https://wa.me/6282141055878"),
                        ),
                        _ContactItem(
                          icon: FontAwesomeIcons.instagram,
                          iconColor: const Color(0xFFE1306C),
                          title: "Instagram",
                          subtitle: "@banksampah_sahabatibu",
                          onTap: () => _launchURL("https://instagram.com/banksampah_sahabatibu"),
                        ),
                        _ContactItem(
                          icon: FontAwesomeIcons.tiktok,
                          iconColor: Colors.black,
                          title: "TikTok",
                          subtitle: "@banksampah_sahabatibu",
                          onTap: () => _launchURL("https://tiktok.com/@banksampah_sahabatibu"),
                        ),
                        _ContactItem(
                          icon: FontAwesomeIcons.envelope,
                          iconColor: Colors.red,
                          title: "Email",
                          subtitle: "BSScotact@gmail.com",
                          onTap: () => _launchURL("mailto:BSSkontact@gmail.com"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Widget Bantuan untuk List Topik (Menggunakan IconData standar)
  Widget _TopicCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.greenSurface,
              child: Icon(icon, color: AppColors.green, size: 20), // Standar Icon
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 10, color: AppColors.muted),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // const Icon(Icons.chevron_right, color: AppColors.muted, size: 20),
          ],
        ),
      ),
    );
  }

  // Widget Bantuan untuk Item Kontak (Menggunakan FaIconData)
  Widget _ContactItem({
    required FaIconData icon, 
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: iconColor.withOpacity(0.1),
        child: FaIcon(icon, color: iconColor, size: 16),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 11, color: AppColors.muted),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
