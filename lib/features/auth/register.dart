
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';
  static const Color _green = Color(0xFF45DD60);
  static const Color _greenDark = Color(0xFF2E7D5B);

  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _nikController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _namaController.dispose();
    _nikController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _alamatController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/register-warga'),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'nama': _namaController.text.trim(),
              'nik': _nikController.text.trim(),
              'email': _emailController.text.trim(),
              'password': _passwordController.text,
              'no_hp': _noHpController.text.trim().isEmpty
                  ? null
                  : _noHpController.text.trim(),
              'alamat': _alamatController.text.trim().isEmpty
                  ? null
                  : _alamatController.text.trim(),
              'jumlah_anggota_keluarga': 1,
            }),
          )
          .timeout(const Duration(seconds: 20));

      final dynamic decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Respons server tidak valid.');
      }

      if (response.statusCode == 201 &&
          decoded['status'] == 'success') {
        if (!mounted) return;

        final message = decoded['message']?.toString() ??
            'Registrasi berhasil. Silakan login.';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: _greenDark,
          ),
        );

        // Kembali ke halaman login.
        Navigator.of(context).pop();
      } else {
        _showError(
          decoded['message']?.toString() ??
              'Registrasi gagal. Periksa kembali data Anda.',
        );
      }
    } on FormatException {
      _showError('Format respons dari server tidak valid.');
    } catch (e) {
      debugPrint('Register API error: $e');

      _showError(
        'Tidak dapat terhubung ke server. '
        'Periksa URL API dan koneksi Anda.',
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD0D0D0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _green, width: 1.5),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffixIcon,
    int? maxLength,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF252525),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          maxLength: maxLength,
          textCapitalization: textCapitalization,
          decoration: _inputDecoration(
            hint,
            suffixIcon: suffixIcon,
          ).copyWith(counterText: ''),
        ),
      ],
    );
  }

  String? _required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAF8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Daftar Akun',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                children: [
                  const Icon(
                    Icons.eco_outlined,
                    size: 64,
                    color: _greenDark,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Gabung Sahabat Ibu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Buat akun untuk mulai mengelola sampah '
                    'dan mendapatkan manfaatnya.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  _buildField(
                    label: 'Nama Lengkap *',
                    hint: 'Masukkan nama sesuai identitas',
                    controller: _namaController,
                    textCapitalization: TextCapitalization.words,
                    validator: (v) {
                      final error = _required(v, 'Nama lengkap');
                      if (error != null) return error;
                      if (v!.trim().length > 100) {
                        return 'Nama maksimal 100 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'NIK *',
                    hint: 'Masukkan 16 digit NIK',
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    validator: (v) {
                      final error = _required(v, 'NIK');
                      if (error != null) return error;
                      if (!RegExp(r'^\d{16}$').hasMatch(v!.trim())) {
                        return 'NIK harus tepat 16 digit angka.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'Email *',
                    hint: 'contoh@email.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      final error = _required(v, 'Email');
                      if (error != null) return error;
                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(v!.trim())) {
                        return 'Format email tidak valid.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'Nomor HP',
                    hint: 'Contoh: 081234567890',
                    controller: _noHpController,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v != null && v.trim().length > 20) {
                        return 'Nomor HP maksimal 20 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'Alamat',
                    hint: 'Masukkan alamat tempat tinggal',
                    controller: _alamatController,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) {
                      if (v != null && v.trim().length > 255) {
                        return 'Alamat maksimal 255 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'Password *',
                    hint: 'Minimal 8 karakter',
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    validator: (v) {
                      final error = _required(v, 'Password');
                      if (error != null) return error;
                      if (v!.length < 8) {
                        return 'Password minimal 8 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  _buildField(
                    label: 'Konfirmasi Password *',
                    hint: 'Masukkan ulang password',
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                        });
                      },
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Konfirmasi password wajib diisi.';
                      }
                      if (v != _passwordController.text) {
                        return 'Konfirmasi password tidak sama.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        disabledBackgroundColor: _green.withOpacity(0.6),
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
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Buat Akun',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sudah punya akun? '),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: _greenDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
