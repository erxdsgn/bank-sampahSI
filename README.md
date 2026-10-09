# Bank Sampah Sahabat Ibu Mobile

Aplikasi mobile untuk pengelolaan Bank Sampah Sahabat Ibu — memudahkan warga mencatat setoran sampah, memantau saldo, dan melihat riwayat transaksi.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)
![License](https://img.shields.io/badge/License-Private-red)

---

## Daftar Isi

- [Tentang Project](#tentang-project)
- [Fitur](#fitur)
- [Teknologi](#teknologi)
- [Persyaratan Sistem](#persyaratan-sistem)
- [Instalasi](#instalasi)
- [Menjalankan Aplikasi](#menjalankan-aplikasi)
- [Struktur Project](#struktur-project)
- [Branching Strategy](#branching-strategy)
- [Konvensi Commit](#konvensi-commit)
- [Alur Kerja Tim](#alur-kerja-tim)
- [Testing](#testing)
- [Build & Release](#build--release)
- [Kontributor](#kontributor)

---

## Tentang Project

**Bank Sampah Sahabat Ibu Mobile** adalah aplikasi Flutter yang dikembangkan untuk mendigitalisasi proses operasional bank sampah. Aplikasi ini membantu:

- Petugas bank sampah dalam mencatat setoran sampah warga
- Warga dalam memantau saldo dan riwayat transaksi
- Pengelola dalam melihat laporan dan statistik

Project ini dikembangkan secara kolaboratif oleh tim menggunakan workflow Git dengan satu branch per anggota.

---

## Fitur

### Fitur Utama (Rencana)
- [ ] Autentikasi (Login & Register)
- [ ] Dashboard pengguna
- [ ] Input setoran sampah
- [ ] Riwayat transaksi
- [ ] Penarikan saldo
- [ ] Manajemen profil
- [ ] Notifikasi

### Fitur Tambahan (Backlog)
- [ ] Laporan statistik bulanan
- [ ] Export data ke PDF/Excel
- [ ] Mode offline
- [ ] Multi-role (Admin, Petugas, Warga)

---

## Teknologi

| Kategori | Teknologi |
|----------|-----------|
| Framework | Flutter 3.x |
| Bahasa | Dart 3.x |
| State Management | Provider |
| HTTP Client | Dio |
| Local Storage | SharedPreferences |
| Version Control | Git + GitHub |

---

## Persyaratan Sistem

Sebelum memulai, pastikan sudah terinstall:

- **Flutter SDK** >= 3.13.3 ([panduan instalasi](https://docs.flutter.dev/get-started/install))
- **Dart SDK** >= 3.13.3 (biasanya sudah termasuk dalam Flutter)
- **Git** ([download](https://git-scm.com/))
- **Editor**: VS Code atau Android Studio
  - Extension VS Code: Flutter, Dart
- **Android Studio / Xcode** (untuk emulator & build)

Cek instalasi:

```bash
flutter doctor
