import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(height: 40),

                
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: const BoxDecoration(
                              color: AppColors.greenSurface, 
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 60,
                              color: AppColors.green,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add_circle,
                                color: AppColors.green,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Login Akun",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Mulai Ubah Sampah Jadi Rupiah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

               
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  hintText: "contoh@gmail.com...",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Email tidak boleh kosong";
                    if (!value.contains('@')) return "Format email salah";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  hintText: "Password minimal 8...",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Password tidak boleh kosong";
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                            activeColor: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Ingat saya",
                          style: TextStyle(fontSize: 12, color: AppColors.textDark),
                        ),
                      ],
                    ),
                   
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Fitur Lupa Password belum tersedia")),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Lupa Password?",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),


                //validasi email dan password 
                if (authProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    authProvider.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),

                
                // Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              final success = await authProvider.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );

                              
                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Login Berhasil!")),
                                );
                                Navigator.pushReplacementNamed(context, AppRoutes.home);
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // link register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum memiliki akun? ",
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}