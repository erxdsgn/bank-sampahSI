import 'package:flutter/material.dart';

// =========================================================
// 1. MODEL DATA (Untuk menyimpan data dummy artikel & event)
// =========================================================
class ItemData {
  final String title;
  final String description;
  final String category;
  final bool isEvent;
  final String? extraInfo; // Bisa untuk Tanggal atau Waktu Baca

  ItemData({
    required this.title,
    required this.description,
    required this.category,
    required this.isEvent,
    this.extraInfo,
  });
}

// =========================================================
// 2. HALAMAN UTAMA (ARTIKEL & EVENT)
// =========================================================
class ArtikelEventPage extends StatefulWidget {
  const ArtikelEventPage({super.key});

  @override
  State<ArtikelEventPage> createState() => _ArtikelEventPageState();
}

class _ArtikelEventPageState extends State<ArtikelEventPage> {
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  // Data Asli
  final List<ItemData> _allData = [
    ItemData(
      title: 'Workshop Bank Sampah Sahabat Ibu',
      description: 'Bagaimana mengelola sampah rumah tangga dengan baik? Mari ikuti workshop ini untuk mempelajari cara daur ulang tingkat dasar bersama pakar lingkungan.',
      category: 'Active Event',
      isEvent: true,
      extraInfo: 'Tanggal: 16 Oktober 2026\nTempat: Perum Gading / 08.00 WIB',
    ),
    ItemData(
      title: 'Cara Memilah Sampah dengan Benar',
      description: 'Pelajari cara memisahkan sampah organik, anorganik, dan residu agar lebih mudah didaur ulang dan mengurangi penumpukan di TPA.',
      category: 'Edukasi Sampah',
      isEvent: false,
      extraInfo: '5 menit membaca',
    ),
    ItemData(
      title: 'Mengenal Bahaya Sampah B3',
      description: 'Kenali jenis sampah B3 (Bahan Berbahaya dan Beracun) dan dampaknya bagi kesehatan serta lingkungan agar dapat ditangani dengan aman.',
      category: 'Edukasi Sampah',
      isEvent: false,
      extraInfo: '4 menit membaca',
    ),
    ItemData(
      title: 'Panduan Daur Ulang Plastik & Kertas',
      description: 'Panduan praktis untuk mendaur ulang sampah plastik dan kertas di rumah menjadi barang yang memiliki nilai jual.',
      category: 'Edukasi Sampah',
      isEvent: false,
      extraInfo: '6 menit membaca',
    ),
  ];

  // Data yang ditampilkan di layar (hasil filter/search)
  List<ItemData> _displayedData = [];

  @override
  void initState() {
    super.initState();
    _displayedData = _allData; // Tampilkan semua data saat pertama kali dibuka
    _searchController.addListener(_runFilter); // Deteksi ketikan user
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk menjalankan Filter & Search
  void _runFilter() {
    String query = _searchController.text.toLowerCase();
    List<ItemData> results = [];

    results = _allData.where((item) {
      // Cek apakah judul mengandung teks pencarian
      bool matchesSearch = item.title.toLowerCase().contains(query);

      // Cek apakah item sesuai dengan chip kategori yang dipilih
      bool matchesCategory = true;
      if (selectedFilter == 'Event') {
        matchesCategory = item.isEvent;
      } else if (selectedFilter == 'Artikel') {
        matchesCategory = !item.isEvent;
      }

      return matchesSearch && matchesCategory;
    }).toList();

    setState(() {
      _displayedData = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF34C759),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Artikel & Event",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // BouncingScrollPhysics agar scroll terasa lebih halus/mantul ala iOS/Android modern
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            _buildFilterChips(),
            const SizedBox(height: 8),
            _buildTodayEventBanner(),
            const SizedBox(height: 16),
            _buildListContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      FocusScope.of(context).unfocus(); // Tutup keyboard
                    },
                  )
                : null,
            hintText: 'Cari Artikel atau Event...',
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    List<String> filters = ['All', 'Event', 'Artikel'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: filters.map((filter) {
          bool isSelected = selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                  _runFilter(); // Jalankan ulang filter saat tombol diklik
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF34C759) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF34C759)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTodayEventBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF34C759), Color(0xFF28A745)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF34C759).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Today Event!",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  "Bank Sampah Sahabat Ibu",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Perumahan Gading",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.event_available,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListContent() {
    if (_displayedData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Text(
            "Hasil tidak ditemukan.",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: _displayedData.map((item) {
          return _buildItemCard(item);
        }).toList(),
      ),
    );
  }

  Widget _buildItemCard(ItemData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // Material & InkWell memberikan efek "ripple" saat di-tap/diklik (tidak kaku)
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigasi ke Halaman Detail saat Card diklik
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(data: data)),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Icon(
                    data.isEvent ? Icons.celebration : Icons.article,
                    size: 50,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF34C759).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            data.category,
                            style: const TextStyle(
                              color: Color(0xFF34C759),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (data.extraInfo != null && !data.isEvent) ...[
                          const SizedBox(width: 8),
                          Text(
                            data.extraInfo!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis, // Bikin teks jadi titik-titik (...) kalau panjang
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Text(
                          "Baca selengkapnya",
                          style: TextStyle(
                            color: Color(0xFF34C759),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF34C759),
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// 3. HALAMAN DETAIL (Tujuan saat "Baca Selengkapnya" diklik)
// =========================================================
class DetailPage extends StatelessWidget {
  final ItemData data;

  const DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF34C759),
        title: Text(
          data.isEvent ? "Detail Event" : "Baca Artikel",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Icon(
                data.isEvent ? Icons.celebration : Icons.article,
                size: 80,
                color: Colors.grey.shade400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF34C759).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data.category,
                      style: const TextStyle(
                        color: Color(0xFF34C759),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (data.extraInfo != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.extraInfo!,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
