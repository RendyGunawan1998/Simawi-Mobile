# Simawi-Mobile

# Deskripsi Aplikasi

SIMAWI Mobile adalah aplikasi manajemen rumah sakit berbasis mobile yang membantu admin dan dokter dalam mengelola data pasien, mencatat rekam medis, serta mencari kode diagnosis penyakit menggunakan integrasi dengan ICD API WHO. Aplikasi ini dirancang untuk mendukung proses pendaftaran pasien dan pencatatan diagnosa secara akurat dengan fitur statistik untuk analisis lebih lanjut. "SIMAWI MOBILE" dikembangkan dengan design yang user-friendly mengingat admin dan dokter yang bekerja memerlukan aplikasi yang mudah digunakan dan responsive. Design yang dikembangkan ini memudahkan admin ataupun dokter untuk mencari fitur yang diperlukan secara cepat dan tidak membuang banyak waktu.

# Catatan :

- Aplikasi debug.apk mungkin akan mengalami masalah ketika diinstal, harap kosongkan space handphone
- Apabila masih tidak bisa menginstall harap coba jalankan codingan di VSCode ataupun Android Studio
- Terima kasih banyak

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
- Jumlah pasien yang terdaftar

2. Manajemen Data User (Admin)

- Tampil, Tambah, edit, dan hapus data user.
- Registrasi Pasien Baru (Admin)
- Fitur pencarian user (Admin)
- Tambah pasien baru atau gunakan data pasien lama.
- Pilih dokter yang akan menangani pasien.

3. Rekam Medis (Dokter)

- Catat gejala pasien, diagnosa awal,keluhan dan pencarian kode ICD-10 melalui integrasi API WHO.
- Simpan dan tampilkan detail rekam medis pasien.

# Endpoint API yang Digunakan

- BASE URL : https://id.who.int/icdapi
- URL GET ACCESS TOKEN : https://icdaccessmanagement.who.int/connect/token
- URL ENTITY ICD-10 : https://id.who.int/icd/entity/search?q={search}
- URL ENTITY DETAIL ICD-10 : https://id.who.int/icd/entity/{id}

# Catatan Teknis dan Kendala Selama Pengembangan

- SQLite Database: Implementasi database lokal untuk menyimpan data pasien dan rekam medis. Kendala muncul pada penanganan relasi tabel antara pasien dan riwayat rekam medis.
- Waktu Pengembangan: Waktu yang terbatas menjadi tantangan utama, sehingga beberapa fitur pengembangan lebih lanjut disederhanakan

# Alur :

1. User Login sebagai Admin

- Untuk login admin menggunakan : admin@example.com sebagai email, dan admin123 untuk password
- Admin akan diarahkan kedalam halaman utama admin yang memunculkan data user
- Admin dapat berperan untuk menambahkan pasien atau mencarikan dokter untuk pasien yang sudah terdaftar
- Pasien datang kepada admin untuk mendaftar
- Apabila pasien belum memiliki akun, admin akan membuat akun dengan meng-klik button "+Tambah Pasien baru" lalu akan diarahkan kehalaman Add Pasien
- Admin memasukkan data diri pasien
- Setelah semua data terisi, admin harus mengklik "Add Patient"

* Untuk pasien lama

- Admin mencari nama pasien pada halaman "Patient Management - Admin" dengan fitur pencarian yang memiliki label "Search by name" kemudian klik icon Cari
- Sistem akan memunculkan data pasien yang dicari
- Admin klik data pasien yang muncul. Admin klik button "+Pilih Dokter" dan akan diarahkan ke halaman "Appointment Doctor - Admin"
- Admin mengisikan data-data pasien seperti gejala yang dirasakan, diganosis awal penyakit, serta memilihkan dokter untuk pasien.
- Admin dapat melihat data pasien secara lengkap pada box data diri pasien dengan mengklik "+See More"
- Setelah semua data selesai diisikan, admin klik "Add Doctor"

* Hapus data pasien

- Admin menekan Icon "Keranjang Sampah" pada bagian bawah data user yang menampilkan role
- Akan muncul pop-up ketika Admin mengklik tombol tersebut dan klik saja "Yes" maka data pasien akan terhapus

* Edit Data Pasien/User

- Admin menekan Icon "Pensil Kertas" pada bagian bawah data user yang menampilkan role
- Admin akan diarahkan kehalaman "Update Patient - Admin"
- Admin dapat mengubah data pasien yang diperlukan
- Setelah semua data terisi, Klik button "Update Patient"

2. User Login sebagai Dokter

- Untuk login sebagai Dokter menggunakan : doctor@example.com sebagai email, dan doctor123 untuk password
- User akan diarahkan kedalam halaman utama "List Patient - Dokter" yang memunculkan data pasien
- Data pasien yang ditampilkan adalah data yang dimasukkan admin berdasarkan dokter yang dipilih untuk pasien tersebut
- Dokter dapat menekan data pasien untuk diarahakan kedalam halaman "Rekam Medis - Doctor"
- Dokter akan mengecek keluhan berdasarkan keterangan pasien, lalu dokter akan memasukkan data tambahan pada form keluhan dan form diagnosa
- Setelah dokter mengisikan diagnosa (Contoh : Fever), dokter meng-klik icon cari dan akan muncul menu dropdown yang berisi diagnosa dari ICD-10 WHO
- Setelah dokter memilih ICD, sistem akan menampilkan deskripsi penyakit, judul, dan data lainnya
- Setelah dokter selesai melakukan tindakan rekam medis, klik "Save Rekam Medis" agar proses dapat selesai

* Update Data Rekam Medis

- Update rekam medis hanya dapat dilakukan pada pasien yang sudah pernah menjalani rekam medis
- Pasien yang sudah pernah melakukan rekam medis akan memiliki tanda yang berbeda berupa Icon Centang berwarna hijau dengan teks "Patient already done diagnose" dibawah "Record Number" pasien
- Dokter menekan data pasien yang memiliki icon centang hijau dan akan diarahakan ke halaman "Update Rekam Medis - Doctor" untuk memperbaharui data
- Setelah dokter memperbaharui data seperti ketika melakukan rekam medis, dokter menekan "Update Rekam Medis"

# Logout

- Fungsi Logout hanya terdapat pada bagian Appbar/Atas aplikasi yang memiliki icon "Exit/Pintu Keluar" berwarna merah
- User harus mengklik icon tersebut dan akan muncul pop-up pemberitahuan apakah user ingin keluar dari aplikasi
- Tekan "Yes" dan user akan diarahkan kembali ke halaman Login

# Dashboard

- Dashboard hanya dapat diakses oleh admin
- Admin perlu melakukan proses "Login"
- Admin akan diarahkan kehalaman "Patient Management - Admin"
- Pada bagian Appbar/Atas aplikasi akan terdapat 2 icon pada pojok kanan atas
- 1 Icon untuk logout, dan 1 lagi icon berbentuk Kotak yang akan mengarahkan ke halaman "Dashboard"
- Admin menekan icon berbentuk kotak dan sistem akan mengarahkan kehalaman "Dashboard - Admin"
- Sistem menampilkan 5 kode Diagnosis ICD-10 yang paling banyak digunakan, jumlah pasien yang terdaftar, serta pasien saat ini
