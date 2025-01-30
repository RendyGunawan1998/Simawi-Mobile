# Simawi-Mobile

# Deskripsi Aplikasi

SIMAWI Mobile adalah aplikasi manajemen rumah sakit berbasis mobile yang membantu admin dan dokter dalam mengelola data pasien, mencatat rekam medis, serta mencari kode diagnosis penyakit menggunakan integrasi dengan ICD API WHO. Aplikasi ini dirancang untuk mendukung proses pendaftaran pasien dan pencatatan diagnosa secara akurat dengan fitur statistik untuk analisis lebih lanjut.

# Catatan :

- Aplikasi debug.apk mungkin akan mengalami masalah ketika diinstal, harap kosongkan space hp
- Apabila masih tidak bisa menginstall harap coba jalankan codingan di VSCode ataupun Android Studio
- Terimas kasih banyak

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

1. User Login sebagai Admin

- Untuk login admin menggunakan : admin@example.com sebagai email, dan admin123 untuk password
- User akan diarahkan kedalam halaman utama admin yang memunculkan data user
- Admin dapat berperan untuk menambahkan user atau mencarikan dokter untuk pasien yang sudah terdaftar
  -Apabila user belum memiliki akun, admin akan membuat akun dengan meng-klik button "+Tambah Pasien baru" lalu akan diarahkan kehalaman Add Pasien
- Admin memasukkan data diri pasien
- Pada saat mengisi "Diagnosis" (Contoh : "Fever"), admin harus meng-klik icon cari agar menampilkan dropdown yang berisi diagnosa dari ICD-10 WHO
- Setelah semua data terisi, admin harus mengklik "Add Patient"

* Untuk pasien lama

- Admin cukup mencari nama pasien pada halaman "Admin - Patient Management" dengan fitur yang memiliki label "Search By name" kemudian klik icon Cari
- Admin klik data pasien yang muncul dan akan diarahkan seperti saat menginputkan data baru pasien namun field nama pasien sudah terisi untuk halaman ini
- Admin mengisikan data-data pasien seperti saat pengisiin data pasien baru
- Setelah semua data selesai diisikan, admin klik "Add Patient"

* Hapus data pasien

- Admin cukup mengklik Icon "Keranjang Sampah" pada bagian bawah data user yang menampilkan role
- Akan muncul pop-up ketika Admin mengklik tombol tersebut dan klik saja "Yes" maka data pasien akan terhapus

* Edit Data Pasien/User

- Admin cukup mengklik Icon "Pensil Kertas" pada bagian bawah data user yang menampilkan role
- Admin akan diarahkan kehalaman pengisiin data user
- Data yang belum terisi berupa umur, gender, Examination Data/Tanggal Kehadiran, serta diagnosis
- Untuk diagnosis ICD-10 harap klik icon "Lensa/Pencarian", maka akan memunculkan data dropdown untuk jenis diagnosa penyakit
- Setelah semua data terisi, Klik "Update Patient"

2. User Login sebagai Dokter

- Untuk login sebagai Dokter menggunakan : doctor@example.com sebagai email, dan doctor123 untuk password
- User akan diarahkan kedalam halaman utama Dokter yang memunculkan data pasien
- Data pasien yang ditampilkan adalah data yang dimasukkan admin berdasarkan dokter yang dipilihkan
- Dokter dapat mengklik data pasien untuk diarahakan kedalam halaman membuat rekam medis
- Dokter akan mengisikan keluhan berdasarkan keterangan pasien, lalu dokter akan memasukkan diagnosa awal
- Setelah dokter mengisikan diagnosa awal (Contoh : Fever), dokter meng-klik icon cari dan akan muncul menu dropdown yang berisi diagnosa dari ICD-10 WHO
- Setelah dokter memilih ICD, akan muncul tombol baru "Tampilkan Deksripsi Penyakit"
- Sistem akan menampilkan deskripsi penyakit, judul, dan data lainnya
- Setelah dokter selesai melakukan tindakan rekam medis, klik "Save Rekam Medis" agar proses dapat selesai

* Update Data Rekam Medis

- Update rekam medis hanya dapat dilakukan pada pasien yang sudah pernah menjalani rekam medis
- Pasien yang sudah pernah melakukan rekam medis akan memiliki tanda yang berbeda berupa Icon Centang yagn berwarna hijau dibawah "Record Number" miliknya
- Dokter menekan data pasien yang memiliki icon centang hijau dan akan diarahakan ke halaman baru untuk memperbaharui data
- Setelah dokter mengisi keluhan dan data lainnya seperti ketika melakukan rekam medis, dokter perlu menekan "Update Rekam Medis"

# Logout

- Fungsi Logout hanya terdapat pada bagian Appbar/Atas aplikasi yang memiliki icon "Exit/Pintu Keluar" berwarna merah
- User harus mengklik icon tersebut dan akan muncul pop-up pemberitahuan apakah user ingin keluar dari aplikasi
- Tekan "Yes" dan user akan diarahkan kembali ke halaman Login

# Dashboard

- Dashboard hanya dapat diakses oleh admin
- Admin perlu melakukan proses "Login"
- Admin akan diarahkan kehalaman "Admin - Patient Management"
- Pada bagian Appbar/Atas aplikasi akan terdapat 2 icon pada pojok kanan atas
- 1 Icon untuk logout, dan 1 lagi icon berbentuk Kotak yang akan mengarahkan ke halaman "Dashboard"
