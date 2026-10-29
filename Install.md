from pathlib import Path

content = """# Installation & Usage Guide

Panduan ini menjelaskan cara menyiapkan dan menjalankan aplikasi **Bank Sampah Sahabat Ibu Mobile** serta backend API Laravel untuk menguji fitur login.

## 1. Prasyarat

Siapkan perangkat pengembangan dengan:

- Flutter SDK dan Dart SDK
- Git
- VS Code atau Android Studio
- Chrome untuk menjalankan aplikasi Flutter Web, atau Android Emulator/perangkat Android
- PHP, Composer, dan database yang dibutuhkan backend Laravel

Verifikasi instalasi Flutter:

```bash
flutter doctor
```

## 2. Clone Aplikasi Flutter

Clone repository lalu masuk ke folder project:

```bash
git clone https://github.com/erxdsgn/bank-sampahSI.git
cd bank-sampahSI
```

Untuk menggunakan branch integrasi login API:

```bash
git fetch origin
git switch -c api_auth_faboy --track origin/api_auth_faboy
```

Jika branch `api_auth_faboy` sudah ada secara lokal, cukup jalankan `git switch api_auth_faboy`.

## 3. Install Dependency Flutter

Dari direktori utama project Flutter, jalankan:

```bash
flutter pub get
```

## 4. Siapkan Backend Laravel

Aplikasi login membutuhkan backend API yang menyediakan endpoint `POST /api/login`. Repository backend:

https://github.com/erxdsgn/bank-sampah-sahabat-ibu

Clone repository backend di folder terpisah:

```bash
git clone https://github.com/erxdsgn/bank-sampah-sahabat-ibu.git
cd bank-sampah-sahabat-ibu
composer install
```

Siapkan file environment dan database sesuai konfigurasi project. Jika belum ada file `.env` dan tersedia `.env.example`, salin menjadi `.env`, lalu atur kredensial database. Setelah konfigurasi selesai, jalankan perintah yang diperlukan:

```bash
php artisan key:generate
php artisan migrate
php artisan serve
```

Jalankan `php artisan migrate` hanya jika database lokal perlu dibuat atau diperbarui. Jika database dan tabel sudah disiapkan, ikuti prosedur backend yang digunakan tim.

Secara default, server Laravel berjalan pada:

`http://127.0.0.1:8000`

Pastikan endpoint `POST /api/login` tersedia dan backend menerima field `username` serta `password`.

## 5. Atur URL API pada Flutter

Buka file:

`lib/features/auth/login.dart`

Sesuaikan nilai `_baseUrl` berdasarkan platform:

| Platform | Base URL |
|---|---|
| Flutter Web / Chrome | `http://127.0.0.1:8000/api` |
| Android Emulator | `http://10.0.2.2:8000/api` |
| Perangkat Android fisik | `http://IP_LAPTOP:8000/api` |

Untuk perangkat fisik, ganti `IP_LAPTOP` dengan IP lokal komputer yang menjalankan Laravel. Pastikan ponsel dan laptop berada di jaringan yang sama serta firewall mengizinkan koneksi.

**Penting:** pada Android Emulator, `127.0.0.1` mengarah ke emulator itu sendiri. Gunakan `10.0.2.2` untuk mengakses localhost komputer host.

Jika menjalankan Flutter Web dan browser menampilkan error CORS, konfigurasi CORS backend perlu mengizinkan origin aplikasi web.

## 6. Jalankan Aplikasi

Biarkan backend Laravel berjalan di terminal pertama:

```bash
php artisan serve
```

Buka terminal kedua pada folder project Flutter, lalu periksa perangkat yang tersedia:

```bash
flutter devices
```

Jalankan aplikasi di Chrome:

```bash
flutter run -d chrome
```

Atau jalankan di emulator/perangkat yang terdeteksi:

```bash
flutter run
```

## 7. Cara Menggunakan Login

1. Pastikan backend Laravel aktif dan dapat diakses dari platform yang digunakan.
2. Jalankan aplikasi Flutter.
3. Pada halaman login, masukkan username dan password akun yang valid di backend.
4. Tekan tombol **Login**.
5. Jika login berhasil, aplikasi menyimpan token autentikasi dan data pengguna menggunakan SharedPreferences, lalu membuka halaman utama.
6. Jika login gagal, periksa kredensial, URL API, koneksi jaringan, dan log backend.

## 8. Troubleshooting

| Kendala | Solusi yang bisa diperiksa |
|---|---|
| Dependency Flutter gagal diunduh | Jalankan ulang `flutter pub get` dan periksa koneksi serta versi Flutter. |
| API tidak bisa diakses | Pastikan `php artisan serve` aktif dan URL API sesuai platform. |
| Login selalu gagal | Pastikan akun valid, nama field request sesuai, dan endpoint `POST /api/login` tersedia. |
| Android Emulator tidak terhubung | Gunakan `10.0.2.2`, bukan `127.0.0.1`. |
| Ponsel fisik tidak terhubung | Gunakan IP lokal laptop, jaringan yang sama, dan periksa firewall. |
| Flutter Web terkena CORS | Periksa konfigurasi CORS pada backend Laravel. |

## Catatan Keamanan

- Jangan commit file `.env`, password, access token, atau kredensial rahasia.
- Gunakan konfigurasi URL yang sesuai dengan lingkungan pengembangan.
- Perintah backend dapat berbeda bergantung pada konfigurasi repository dan kondisi database.
"""
path = Path("/mnt/data/INSTALL.md")
path.write_text(content, encoding="utf-8")
print(f"Created {path} ({path.stat().st_size} bytes)")
