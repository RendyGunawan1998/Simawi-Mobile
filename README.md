# Simawi-Mobile

# Deskripsi Aplikasi

SIMAWI Mobile adalah aplikasi manajemen rumah sakit berbasis mobile yang membantu admin dan dokter dalam mengelola data pasien, mencatat rekam medis, serta mencari kode diagnosis penyakit menggunakan integrasi dengan ICD API WHO. Aplikasi ini dirancang untuk mendukung proses pendaftaran pasien dan pencatatan diagnosa secara akurat dengan fitur statistik untuk analisis lebih lanjut.

# Akun Login

1. Dokter 1:
   'Email': 'doctor@example.com',
   'Password': 'doctor123',

2. Dokter 2:
   'Email': 'doctor2@example.com',
   'Password': 'doctor123',

3. Admin:
   'Email': 'admin@example.com',
   'Password': 'admin123',

# Fitur Utama

1.Dashboard

- Statistik jumlah pasien yang terdaftar.
- 5 kode diagnosis ICD-10 terpopuler dalam bentuk pie chart.

2. Manajemen Data User (Admin)

- Tampil, Tambah, edit, dan hapus data user.
- Registrasi Pasien Baru (Admin)
- Fitur pencarian user (Admin)
- Tambah pasien baru atau gunakan data pasien lama.
- Pilih dokter yang akan menangani pasien.

3. Tampil Data Dashboard (Admin)

4. Rekam Medis (Dokter)

- Catat gejala pasien, diagnosa awal,keluhan dan pencarian kode ICD-10 melalui integrasi API WHO.
- Simpan dan tampilkan detail rekam medis pasien.

# Endpoint API yang Digunakan

- BASE URL : https://id.who.int/icdapi
- URL GET ACCESS TOKEN : https://icdaccessmanagement.who.int/connect/token
- URL ENTITY ICD-10 : https://id.who.int/icd/entity/search?q=

# Catatan Teknis dan Kendala Selama Pengembangan

- SQLite Database: Implementasi database lokal untuk menyimpan data pasien dan rekam medis. Kendala muncul pada penanganan relasi tabel antara pasien dan riwayat rekam medis.
- Waktu Pengembangan: Waktu yang terbatas menjadi tantangan utama, sehingga beberapa fitur pengembangan lebih lanjut disederhanakan

# Alur :

1. User Login dengan memasukkan email dan password

- Untuk login admin menggunakan : admin@example.com sebagai email, dan admin123 untuk password
- User akan diarahkan kedalam halaman utama admin yang memunculkan data user
- Admin dapat berperan untuk menambahkan user atau mencarikan dokter untuk pasien yang sudah terdaftar
  -Apabila user belum memiliki akun, admin akan membuat akun dengan meng-klik button "+Tambah Pasien baru" lalu akan diarahkan kehalaman Add Pasien
- Admin memasukkan data diri pasien
- Pada saat mengisi "Diagnosis", admin harus meng-klik icon cari agar menampilkan dropdown yang berisi diagnosa dari ICD-10 WHO
- Setelah semua data terisi, admin harus mengklik "Add Patient"
