# Olfe Veri Merkezi A.Ş. – iDRAC6 KVM Launcher

Legacy Dell iDRAC6 sistemlerde modern tarayıcılarla çalışmayan Virtual Console (KVM) erişimini sağlamak için hazırlanmış bir araçtır.

---

## 🇹🇷 Türkçe

### 🚀 Amaç

iDRAC6, eski Java tabanlı yapısı nedeniyle modern sistemlerde çalışmaz.
Bu araç, gerekli dosyaları otomatik indirerek KVM bağlantısını başlatır.

---

### ⚙️ Özellikler

* Otomatik Java tespiti
* 32-bit / 64-bit uyumlu native library indirimi
* iDRAC üzerinden gerekli `.jar` dosyalarını otomatik çekme
* Virtual Console (KVM) desteği
* Virtual Media desteği
* Debug log çıktısı

---

### 📦 Kullanım

```bash
idrac6-kvm-launcher.bat
```

Ardından:

* iDRAC IP adresi
* Kullanıcı adı
* Şifre

girmeniz yeterlidir.

---

### 📋 Gereksinimler

* Windows işletim sistemi
* Java (tercihen Java 8)
* iDRAC6 üzerinde Virtual Console aktif olmalı
* TCP 5900 portu erişilebilir olmalı

---

### ⚠️ Notlar

* Java 17+ sürümlerde sorun yaşanabilir
* Virtual Media için Java mimarisi ile DLL mimarisi aynı olmalıdır (32/64-bit)
* Sorun yaşarsanız `lib` klasörünü silip tekrar deneyin

---

## 🇬🇧 English

### 🚀 Purpose

This tool enables Virtual Console (KVM) access for legacy Dell iDRAC6 systems that no longer work properly with modern browsers.

---

### ⚙️ Features

* Automatic Java detection
* 32-bit / 64-bit native library handling
* Auto-download of required `.jar` files from iDRAC
* Virtual Console (KVM) support
* Virtual Media support
* Debug logging output

---

### 📦 Usage

```bash
idrac6-kvm-launcher.bat
```

Then enter:

* iDRAC IP address
* Username
* Password

---

### 📋 Requirements

* Windows OS
* Java (Java 8 recommended)
* Virtual Console must be enabled on iDRAC6
* TCP port 5900 must be reachable

---

### ⚠️ Notes

* Java 17+ may cause compatibility issues
* Virtual Media requires matching Java and native library architecture (32/64-bit)
* If errors occur, try deleting the `lib` folder and run again

---

## 🏢 About Us

**Olfe Veri Merkezi A.Ş.**
Dijital dünyanın güvenilir ortağı.

---

## 📄 License

This project is provided as-is for community use.
