import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import 'login.dart';
import 'account_created_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  int? _selectedAnggota;

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AccountCreatedPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Memastikan semua anak column rata kiri
            children: [
              // --- HEADER GAMBAR & TEKS ---
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/RegisterProfile.png', height: 75),
                    const SizedBox(height: 12),
                    const Text(
                      "Buat Akun",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Gabung menjadi nasabah bank sampah sahabat ibu",
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- FORM INPUT ---
              _buildInputLabel("Nama Lengkap"),
              TextFormField(
                validator: (v) => v!.isEmpty ? "Nama wajib diisi" : null,
                decoration: _inputDecoration("Masukkan nama anda..."),
              ),
              const SizedBox(height: 14),

              _buildInputLabel("NIK"),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (v) => v!.length != 16 ? "NIK harus 16 digit" : null,
                decoration: _inputDecoration("Nomor Induk Keluarga..."),
              ),
              const SizedBox(height: 14),

              // Baris WhatsApp & Anggota Keluarga
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("WhatsApp Aktif"),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (v) => !RegExp(r'^[0-9]+$').hasMatch(v!) ? "Angka saja" : null,
                          decoration: _inputDecoration("0812345..."),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputLabel("Anggota Keluarga"),
                        DropdownButtonFormField<int>(
                          value: _selectedAnggota,
                          items: List.generate(
                            10,
                            (i) => DropdownMenuItem(value: i + 1, child: Text("${i + 1}")),
                          ),
                          onChanged: (val) => setState(() => _selectedAnggota = val),
                          validator: (v) => v == null ? "Pilih" : null,
                          decoration: _inputDecoration("1-10"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              _buildInputLabel("Email"),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (v) => !v!.contains('@') ? "Email tidak valid" : null,
                decoration: _inputDecoration("contoh@gmail.com..."),
              ),
              const SizedBox(height: 14),

              _buildInputLabel("Alamat"),
              TextFormField(
                maxLines: 3, // Dibuat 3 baris agar lebih lega seperti referensi
                validator: (v) => v!.isEmpty ? "Alamat wajib diisi" : null,
                decoration: _inputDecoration("Jl. letjen suprapto..."),
              ),
              const SizedBox(height: 14),

              _buildInputLabel("Password"),
              TextFormField(
                obscureText: _obscurePassword,
                validator: (v) => v!.length < 8 ? "Minimal 8 karakter" : null,
                decoration: _inputDecoration("Password minimal 8...").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- TOMBOL DAFTAR ---
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Daftar",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- FOOTER LOGIN ---
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah memiliki akun? ", style: TextStyle(fontSize: 12)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24), // Spasi bawah extra
            ],
          ),
        ),
      ),
    );
  }

  // Helper Label dengan Alignment Kiri Eksplisit
  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, left: 2.0), // Diberi sedikit padding kiri
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13, // Sedikit diperbesar agar mudah dibaca
            fontWeight: FontWeight.w600, // Dibuat semi-bold
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  // Helper Dekorasi Input yang Konsisten
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}