import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  bool _isEditMode = false;

  // controller
  final _namaController = TextEditingController(text: "Erix Agung Wibowo");
  final _usernameController = TextEditingController(text: "erix_agung_1278");
  final _emailController = TextEditingController(text: "erix@gmail.com");
  final _waController = TextEditingController(text: "089123456...");
  
  String? _selectedKelompok = "Kelompok A";
  String? _selectedAnggota = "3 Orang";

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _waController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _saveChanges() {
    // logika api
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data berhasil disimpan!")),
    );
    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Container(
            width: double.infinity,
            color: AppColors.green,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                const Text(
                  "Informasi Pribadi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
             
             // edit
                Positioned(
                  right: 0,
                  child: _isEditMode 
                    ? const SizedBox() 
                    : InkWell(
                        onTap: _toggleEdit,
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),

          // form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Label("Nama Lengkap"),
                  _TextField(_namaController, enabled: _isEditMode),
                  
                  _Label("Nama Pengguna"),
                  _TextField(_usernameController, enabled: _isEditMode),
                  
                  /// email dan wa
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Label("Email"),
                            _TextField(_emailController, enabled: _isEditMode),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Label("Nomor WhatsApp"),
                            _TextField(_waController, enabled: _isEditMode),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Baris Kelompok & Anggota
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Label("Kelompok"),
                            _Dropdown(
                              value: _selectedKelompok,
                              items: ["Kelompok A", "Kelompok B", "Kelompok C"],
                              onChanged: _isEditMode ? (val) {
                                setState(() { _selectedKelompok = val; });
                              } : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Label("Anggota Keluarga"),
                            _Dropdown(
                              value: _selectedAnggota,
                              items: ["1 Orang", "2 Orang", "3 Orang", "4 Orang"],
                              onChanged: _isEditMode ? (val) {
                                setState(() { _selectedAnggota = val; });
                              } : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // button simpan
                  if (_isEditMode)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Simpan Perubahan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _Label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, color: AppColors.muted),
      ),
    );
  }

  Widget _TextField(TextEditingController controller, {bool enabled = false}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(fontSize: 13, color: AppColors.textDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.green),
        ),
      ),
    );
  }

  Widget _Dropdown({
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted),
      style: const TextStyle(fontSize: 13, color: AppColors.textDark),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.green),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}