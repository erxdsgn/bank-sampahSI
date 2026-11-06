
import 'dart:convert';
import 'register.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _green = Color(0xFF45DD60);
  static const _greenDark = Color(0xFF2E7D5B);
  static const _border = Color(0xFFD0D0D0);
  static const _hint = Color(0xFFBDBDBD);
  static const _muted = Color(0xFF808080);

  // Android Emulator + Laravel php artisan serve port 8000.
  // Chrome: http://127.0.0.1:8000/api
  // HP fisik: http://IP_LAPTOP:8000/api
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  final _formLoginKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _obscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoading) return;

    if (!_formLoginKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/login'),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'username': _emailController.text.trim(),
              'password': _passwordController.text,
            }),
          )
          .timeout(const Duration(seconds: 20));

      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException(
          'Format respons server tidak valid.',
        );
      }

      if (response.statusCode == 200 &&
          decoded['status'] == 'success') {
        final data = decoded['data'];

        if (data is! Map<String, dynamic>) {
          throw const FormatException(
            'Data login tidak valid.',
          );
        }

        final token = data['token'];
        final user = data['user'];

        if (token is! String ||
            token.isEmpty ||
            user is! Map<String, dynamic>) {
          throw const FormatException(
            'Token atau data pengguna tidak ditemukan.',
          );
        }

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('auth_token', token);
        await prefs.setString('auth_user', jsonEncode(user));

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MainNavigation(),
          ),
        );
      } else {
        _showMessage(
          decoded['message']?.toString() ??
              'Login gagal. Periksa akun Anda.',
          isError: true,
        );
      }
    } on FormatException catch (e) {
      _showMessage(e.message, isError: true);
    } catch (e) {
      debugPrint('Login API error: $e');

      _showMessage(
        'Tidak dapat terhubung ke server. '
        'Periksa URL API dan koneksi Anda.',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : _greenDark,
      ),
    );
  }

  OutlineInputBorder _outline(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 1.2),
      );

  InputDecoration _decoration(String hint, {Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: _hint, fontSize: 16),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      enabledBorder: _outline(_border),
      focusedBorder: _outline(_green),
      errorBorder: _outline(Colors.red.shade300),
      focusedErrorBorder: _outline(Colors.red.shade400),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF222222),
          ),
        ),
      );

  Widget _avatar() {
    return SizedBox(
      width: 160,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(
              color: Color(0xFFD9D9D9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 96,
              color: _greenDark,
            ),
          ),
          Positioned(
            top: 12,
            right: 8,
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: _greenDark,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
            ),
            child: Form(
              key: _formLoginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.maybePop(context),
                  ),

                  const SizedBox(height: 90),

                  Center(child: _avatar()),

                  const SizedBox(height: 16),

                  const Center(
                    child: Text(
                      'Login Akun',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Center(
                    child: Text(
                      'Mulai Ubah Sampah Jadi Rupiah',
                      style: TextStyle(
                        fontSize: 16,
                        color: _muted,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  _label('Email atau Username'),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: _decoration(
                      'Email atau username...',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email atau username wajib diisi';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _label('Password'),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                    decoration: _decoration(
                      'Masukkan password...',
                      suffix: IconButton(
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color.fromARGB(255, 87, 87, 87),
                        ),
                        onPressed: () {
                          setState(() => _obscure = !_obscure);
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi';
                      }
                      if (value.length < 8) {
                        return 'Password minimal 8 karakter';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: _green,
                          checkColor: Colors.white,
                          side: const BorderSide(
                            color: _border,
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Text(
                        'Ingat saya',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF222222),
                        ),
                      ),

                      const Spacer(),

                      GestureDetector(
                        onTap: () {
                          // TODO: halaman lupa password.
                        },
                        child: const Text(
                          'Lupa Password?',
                          style: TextStyle(
                            fontSize: 16,
                            color: _green,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 56),

                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: _green.withOpacity(0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        disabledBackgroundColor: _green,
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
                              'Login',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Belum memiliki akun? ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: _muted,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: _green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
