# Rumah Sehat Mobile (Flutter)

## Cara pakai
1. `flutter create rumah_sehat` (nama project harus rumah_sehat)
2. Timpa folder `lib/` dan file `pubspec.yaml` dengan yang ada di zip ini
3. `flutter pub get`

## Khusus Android (emulator / HP)
Edit `android/app/src/main/AndroidManifest.xml`:
- tambah di atas tag <application>:  <uses-permission android:name="android.permission.INTERNET"/>
- tambah atribut di tag <application>:  android:usesCleartextTraffic="true"

## Server Laravel
Jalankan `php artisan serve` di folder rumah-sehat-api.
Alamat API diatur di lib/services/api_service.dart (emulator Android = 10.0.2.2).
Akun tes: putri@mail.com / password123
