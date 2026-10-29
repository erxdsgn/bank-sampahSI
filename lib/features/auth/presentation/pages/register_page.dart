import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_routes.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/custom_dropdown.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  final _waController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedAnggotaKeluarga;

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _waController.dispose();
    _emailController.dispose();
    _addressController.dispose();
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
                // --- TOMBOL BACK ---
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(height: 20),

                // --- HEADER (Avatar & Judul) ---
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: AppColors.greenSurface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Buat Akun",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Gabung menjadi nasabah bank sampah sehat Bu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // --- FORM INPUTS ---
                
                CustomTextField(
                  label: "Nama Lengkap",
                  controller: _nameController,
                  hintText: "Masukkan nama anda...",
                  validator: (value) => value!.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "NIK",
                  controller: _nikController,
                  hintText: "Nomor Induk Kependudukan...",
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "NIK tidak boleh kosong" : null,
                ),
                const SizedBox(height: 16),

                // WhatsApp & Anggota Keluarga (Row)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextField(
                        label: "WhatsApp Aktif",
                        controller: _waController,
                        hintText: "0812345...",
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: CustomDropdown(
                        label: "Anggota Keluarga",
                        hintText: "1-10",
                        value: _selectedAnggotaKeluarga,
                        items: List.generate(10, (index) => "${index + 1} Orang"),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedAnggotaKeluarga = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  hintText: "contoh@gmail.com...",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Email kosong";
                    if (!value.contains('@')) return "Format salah";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Alamat",
                  controller: _addressController,
                  hintText: "Jl. letjen suprapto...",
                  maxLines: 3, // Dibuat lebih tinggi untuk alamat
                  validator: (value) => value!.isEmpty ? "Alamat tidak boleh kosong" : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  hintText: "Password minimal 8...",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Password kosong";
                    if (value.length < 8) return "Minimal 8 karakter";
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // --- TOMBOL DAFTAR ---
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              if (_selectedAnggotaKeluarga == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Pilih jumlah anggota keluarga!")),
                                );
                                return;
                              }

                              final success = await authProvider.register(
                                name: _nameController.text,
                                nik: _nikController.text,
                                wa: _waController.text,
                                email: _emailController.text,
                                address: _addressController.text,
                                password: _passwordController.text,
                                anggotaKeluarga: _selectedAnggotaKeluarga!,
                              );

                              if (success && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Registrasi Berhasil!")),
                                );
                                Navigator.pushReplacementNamed(context, AppRoutes.login);
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Sesuai gambar, kotak melengkung tipis
                      ),
                    ),
                    child: authProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                          )
                        : const Text(
                            "Daftar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // --- LINK KE LOGIN ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah memiliki akun? ",
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                      child: const Text(
                        "Login",
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