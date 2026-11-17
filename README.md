# 124240030_latres_D — Toko Online Flutter

Aplikasi toko online sederhana sebagai Latihan Responsi Praktikum Pemrograman Mobile SI-D.
Data produk diambil dari API eksternal `https://dummyjson.com/products`.

## Cara Menjalankan
1. `flutter pub get`
2. `flutter pub run build_runner build --delete-conflicting-outputs`
3. `flutter run`

## Login
- Username: bebas 
- Password: 124240030

## Struktur Folder
```text
lib/
├── main.dart                 # Entry point, inisialisasi Hive & GetX
├── models/
│   ├── product_model.dart    # Model produk dari API
│   └── cart_item_model.dart  # Model Hive untuk cart (TypeAdapter)
├── controllers/
│   ├── auth_controller.dart  # Login/logout, session SharedPreferences
│   ├── product_controller.dart # Fetch produk dari dummyjson
│   └── cart_controller.dart  # CRUD cart Hive, filter per username
├── services/
│   ├── api_service.dart      # HTTP GET ke dummyjson
│   └── hive_service.dart     # Init Hive + register adapter + open box
├── views/
│   ├── login_view.dart       # Form login (password = NIM)
│   ├── main_view.dart        # BottomNavigationBar (Home, Profile)
│   ├── home_view.dart        # Greeting username, tombol cart, list produk
│   ├── detail_view.dart      # Detail produk + qty + Add to Cart
│   ├── cart_view.dart        # List cart per user, hapus item
│   └── profile_view.dart     # Info username, deskripsi, logout
└── widgets/
    └── product_card.dart     # Widget kartu produk reusable