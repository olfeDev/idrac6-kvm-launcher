# Olfe iDRAC6 Virtual Console Launcher

Legacy Dell iDRAC6 sistemlerde modern tarayıcılarla çalışmayan Java tabanlı Virtual Console/KVM istemcisini manuel olarak başlatmak için hazırlanmış Windows batch aracıdır.

## Özellikler

- Java yolunu otomatik bulur
- Java 32-bit / 64-bit mimarisini algılar
- iDRAC üzerinden gerekli `avctKVM.jar` dosyasını indirir
- Uygun native library paketlerini indirir
- Hataları ekranda tutar
- Virtual Console ve Virtual Media desteği sağlar

## Kullanım

```bat idrac6-kvm-launcher.bat```
