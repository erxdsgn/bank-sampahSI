
# Instalasi — Bank Sampah Sahabat Ibu Mobile

Panduan untuk menginstal, mengonfigurasi, dan menjalankan aplikasi mobile Bank Sampah Sahabat Ibu menggunakan Flutter dan backend API Laravel.

## Daftar Isi

- [Persyaratan](#1-persyaratan)
- [Clone Repository](#2-clone-repository)
- [Instalasi Flutter](#3-instalasi-flutter)
- [Konfigurasi Backend Laravel](#4-konfigurasi-backend-laravel)
- [Konfigurasi URL API](#5-konfigurasi-url-api)
- [Menjalankan Aplikasi](#6-menjalankan-aplikasi)
- [Pengujian Login](#7-pengujian-login)
- [Troubleshooting](#8-troubleshooting)
- [Keamanan](#9-keamanan)

## 1. Persyaratan

Pastikan perangkat pengembangan sudah memiliki:

- Flutter SDK dan Dart SDK.
- Git.
- Visual Studio Code atau Android Studio.
- Google Chrome atau Android Emulator.
- PHP dan Composer untuk backend Laravel.
- Database yang sesuai dengan konfigurasi backend.

Periksa instalasi Flutter:

```bash
flutter doctor
```

Pastikan tidak ada masalah penting pada konfigurasi Flutter sebelum melanjutkan.

## 2. Clone Repository

Clone repository aplikasi mobile:

```bash
git clone https://github.com/erxdsgn/bank-sampahSI.git
cd bank-sampahSI
```

Pindah ke branch autentikasi API:

```bash
git switch api_auth_faboy
```

Jika branch belum tersedia secara lokal:

```bash
git fetch origin
git switch --track origin/api_auth_faboy
```

Periksa branch aktif:

```bash
git branch --show-current
```

Pastikan hasilnya:

```text
api_auth_faboy
```

## 3. Instalasi Flutter

Dari direktori utama project, jalankan:

```bash
flutter pub get
```

Periksa perangkat yang tersedia:

```bash
flutter devices
```

Jika dependency gagal diunduh, periksa koneksi internet dan versi Flutter yang terpasang.

## 4. Konfigurasi Backend Laravel

Aplikasi membutuhkan backend API yang menyediakan endpoint login.

Repository backend:

https://github.com/erxdsgn/bank-sampah-sahabat-ibu

Clone backend di direktori terpisah:

```bash
git clone https://github.com/erxdsgn/bank-sampah-sahabat-ibu.git
cd bank-sampah-sahabat-ibu
composer install
```

Siapkan file environment. Jika `.env` belum tersedia dan `.env.example` memang ada, salin file tersebut.

Windows Command Prompt:

```bat
copy .env.example .env
```

Linux atau macOS:

```bash
cp .env.example .env
```

Konfigurasikan koneksi database pada file `.env`, lalu jalankan:

```bash
php artisan key:generate
```

Jalankan migrasi hanya jika diperlukan dan sesuai kondisi database:

```bash
php artisan migrate
```

Nyalakan server Laravel:

```bash
php artisan serve
```

Secara default, server berjalan di:

```text
http://127.0.0.1:8000
```

Pastikan endpoint berikut benar-benar tersedia pada backend:

```text
POST /api/login
```

Nama field request dan format respons harus sesuai dengan implementasi autentikasi backend dan aplikasi Flutter.

## 5. Konfigurasi URL API

Buka file berikut pada project Flutter:

```text
lib/features/auth/login.dart
```

Sesuaikan nilai `_baseUrl` dengan platform yang digunakan.

| Platform | Base URL |
|---|---|
| Flutter Web / Chrome | `http://127.0.0.1:8000/api` |
| Android Emulator | `http://10.0.2.2:8000/api` |
| Android fisik | `http://IP_LAPTOP:8000/api` |

### Android Emulator

Gunakan alamat:

```text
http://10.0.2.2:8000/api
```

Alamat `10.0.2.2` digunakan emulator Android untuk mengakses localhost komputer host.

### Android Fisik

Ganti `IP_LAPTOP` dengan alamat IP lokal komputer yang menjalankan Laravel.

Pastikan ponsel dan komputer terhubung ke jaringan yang sama dan firewall mengizinkan koneksi.

### Flutter Web

Jika browser menampilkan error CORS, konfigurasi CORS pada backend Laravel perlu mengizinkan origin aplikasi web.

Catatan: gunakan HTTP hanya untuk lingkungan pengembangan lokal. Untuk deployment, gunakan HTTPS.

## 6. Menjalankan Aplikasi

Jalankan backend Laravel pada terminal pertama:

```bash
php artisan serve
```

Pada terminal kedua, buka direktori project Flutter:

```bash
flutter pub get
flutter devices
```

Jalankan aplikasi melalui Chrome:

```bash
flutter run -d chrome
```

Atau jalankan pada emulator maupun perangkat yang tersedia:

```bash
flutter run
```

Pastikan backend tetap aktif selama aplikasi membutuhkan API.

## 7. Pengujian Login

1. Pastikan backend Laravel berjalan.
2. Pastikan URL API sesuai dengan platform.
3. Buka aplikasi Flutter.
4. Masukkan username dan password akun yang valid pada backend.
5. Tekan tombol Login.
6. Periksa respons aplikasi jika login berhasil atau gagal.

Jika login berhasil, aplikasi seharusnya mengikuti alur autentikasi yang diterapkan pada project.

Jika login gagal, periksa pesan error, request API, respons backend, dan log Laravel.

## 8. Troubleshooting

| Masalah | Solusi |
|---|---|
| `flutter pub get` gagal | Periksa koneksi internet dan versi Flutter. |
| Backend tidak bisa dijalankan | Periksa instalasi PHP, Composer, dan konfigurasi Laravel. |
| File `.env` tidak ditemukan | Pastikan `.env.example` tersedia sebelum menyalinnya. |
| Database error | Periksa kredensial database dan status server database. |
| API tidak dapat diakses | Pastikan Laravel berjalan dan URL API benar. |
| Login selalu gagal | Periksa kredensial, field request, endpoint, dan format respons API. |
| Android Emulator gagal terhubung | Gunakan `10.0.2.2`, bukan `127.0.0.1`. |
| Android fisik gagal terhubung | Periksa IP komputer, jaringan, dan firewall. |
| Flutter Web mengalami CORS | Periksa konfigurasi CORS backend. |

## 9. Keamanan

- Jangan commit file `.env` yang berisi kredensial.
- Jangan menyimpan password atau token rahasia dalam repository.
- Jangan mengunggah access token ke GitHub.
- Gunakan HTTPS untuk komunikasi API pada lingkungan produksi.
- Pastikan konfigurasi autentikasi dan penyimpanan token mengikuti kebutuhan keamanan aplikasi.

---

**Repository Mobile:** https://github.com/erxdsgn/bank-sampahSI

**Branch:** `api_auth_faboy`

**Repository Backend:** https://github.com/erxdsgn/bank-sampah-sahabat-ibu
