import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Warna tema yang disamakan persis dengan halaman login
  static const Color primaryGreen = Color(0xFF45DD60);
  static const Color darkGreen = Color(0xFF2E7D5B);
  static const Color borderColor = Color(0xFFD0D0D0);
  static const Color hintColor = Color(0xFFBDBDBD);
  static const Color mutedColor = Color(0xFF808080);

  // Controller input form
  final _nameController = TextEditingController();
  final _emailController =
      TextEditingController(); // Controller email yang ditambahkan
  final _nikController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _nikController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi Register yang terhubung ke API Laravel
  void _handleRegister() async {
    // 1. Validasi form kosong
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _nikController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua kolom wajib diisi ya!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // 2. Tentukan URL API Laravel (Gunakan 127.0.0.1 jika di web, atau 10.0.2.2 jika di emulator Android)
    final url = Uri.parse('http://127.0.0.1:8000/api/register-warga');

    try {
      // 3. Kirim data menggunakan HTTP POST dengan key yang sesuai backend Laravel
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'nama': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'nik': _nikController.text.trim(),
          'no_hp': _phoneController.text.trim(),
          'alamat': _addressController.text.trim(),
          'password': _passwordController.text,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Jika Registrasi Berhasil dari Laravel
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              responseData['message'] ?? 'Registrasi Berhasil! Silakan Login.',
            ),
            backgroundColor: darkGreen,
          ),
        );
        // Kembali ke halaman login
        Navigator.pop(context);
      } else {
        // Jika Gagal (misal NIK/Email sudah terdaftar atau validasi error)
        String errorMessage =
            responseData['message'] ?? 'Terjadi kesalahan saat registrasi.';
        if (responseData['errors'] != null) {
          var errors = responseData['errors'];
          errorMessage =
              errors[errors.keys.first][0]; // Ambil pesan error pertama
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal terhubung ke server: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Akun Baru',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Bergabunglah dengan Bank Sampah Sahabat Ibu',
                style: TextStyle(fontSize: 15, color: mutedColor),
              ),
              const SizedBox(height: 32),

              // Input Nama Lengkap
              _buildFieldLabel('Nama Lengkap'),
              TextField(
                controller: _nameController,
                decoration: _inputDecoration('Masukkan nama lengkap...'),
              ),
              const SizedBox(height: 16),

              // Input Email
              _buildFieldLabel('Email'),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('contoh@gmail.com...'),
              ),
              const SizedBox(height: 16),

              // Input NIK
              _buildFieldLabel('NIK'),
              TextField(
                controller: _nikController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration('Masukkan 16 digit NIK...'),
              ),
              const SizedBox(height: 16),

              // Input No Telepon
              _buildFieldLabel('Nomor Telepon / WhatsApp'),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration('Contoh: 08123456789...'),
              ),
              const SizedBox(height: 16),

              // Input Alamat
              _buildFieldLabel('Alamat Lengkap'),
              TextField(
                controller: _addressController,
                maxLines: 2,
                decoration: _inputDecoration('Masukkan alamat rumah...'),
              ),
              const SizedBox(height: 16),

              // Input Password
              _buildFieldLabel('Password'),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  'Minimal 8 karakter...',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: mutedColor,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Tombol Daftar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF222222),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: hintColor, fontSize: 15),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryGreen, width: 1.2),
      ),
    );
  }
}
