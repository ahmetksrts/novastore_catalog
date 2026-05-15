# NovaStore Catalog

NovaStore Catalog, Flutter ile geliştirilmiş mini bir e-ticaret katalog uygulamasıdır. Uygulamada teknoloji ürünleri API üzerinden alınır, ürünler kart yapısında listelenir, ürün detayları görüntülenir ve ürünler sepete eklenip sepetten çıkarılabilir.

Proje; Flutter proje yapısını, API kullanımıyla veri çekmeyi, JSON verisini model sınıfına dönüştürmeyi, ekranlar arası geçişleri, GridView kullanımını, tema yönetimini, dil seçimini ve basit sepet state mantığını göstermek amacıyla hazırlanmıştır.

## Proje Amacı

Bu uygulamanın amacı, bir e-ticaret uygulamasının temel katalog yapısını küçük ölçekte simüle etmektir. Kullanıcı ana sayfada ürünleri görüntüleyebilir, kategoriye göre filtreleme yapabilir, ürün detayına geçebilir ve istediği ürünleri sepete ekleyebilir.

Projede özellikle şu konular uygulanmıştır:

- Flutter proje yapısı
- StatelessWidget ve StatefulWidget kullanımı
- API üzerinden veri çekme
- JSON verisini model sınıfına dönüştürme
- Navigator ile sayfalar arası geçiş
- GridView ile ürün kartlarının listelenmesi
- Responsive ürün kartı tasarımı
- Ürün detay sayfası
- Sepet işlemleri için basit state yönetimi
- Light ve Dark tema desteği
- Türkçe ve İngilizce dil seçimi
- API görsellerinin Image.network ile gösterilmesi
- Ana sayfa banner alanında ikinci görsel API kullanımı

## Kullanılan Teknolojiler

- Flutter 3.41.9
- Dart 3.11.5
- DevTools 2.54.2
- Material Design
- Android Studio
- Android language: Kotlin
- HTTP paketi
- WantAPI ürün API'si
- Picsum görsel API'si

Proje geliştirilirken kullanılan Flutter ve Android ortamı:

```text
Flutter 3.41.9 • channel stable
Dart 3.11.5
DevTools 2.54.2
```

Ekstra backend, veritabanı veya karmaşık state management paketi kullanılmamıştır. Proje, eğitim kapsamında anlaşılır ve sade bir Flutter uygulaması olacak şekilde geliştirilmiştir.

## API Kullanımı

Projede iki farklı API kullanılmıştır.

### 1. WantAPI Ürün API'si

Uygulamanın ana ürün verileri WantAPI üzerinden alınmaktadır.

```text
https://wantapi.com/products.php
```

Bu API üzerinden gelen başlıca veriler:

- Ürün id bilgisi
- Ürün adı
- Ürün açıklaması
- Ürün sloganı
- Ürün fiyatı
- Para birimi
- Ürün görsel URL'si
- Teknik özellikler

API'den gelen JSON verisi `Product` modeline dönüştürülmektedir. Ürün adı, açıklama, fiyat ve görsel bağlantısı uygulama içinde bu model üzerinden kullanılmaktadır.

Veri akışı genel olarak şöyledir:

```text
WantAPI
↓
lib/services/product_api_service.dart
↓
Product modeli
↓
main.dart
↓
home_screen.dart
product_list_screen.dart
product_detail_screen.dart
cart_screen.dart
```

API fiyatları USD olarak gelmektedir. Uygulamada İngilizce dil seçildiğinde fiyatlar dolar olarak gösterilir. Türkçe dil seçildiğinde fiyatlar sabit kur mantığıyla TL'ye çevrilir. Bu projede örnek hesaplama için 1 dolar = 45 TL kabul edilmiştir.

Örnek:

```text
$10 → 450 TL
$999 → 44955 TL
```

WantAPI kategori alanı göndermediği için ürün kategorileri ürün adına göre uygulama içinde belirlenmektedir. Örneğin iPhone ürünleri Telefon, MacBook ve iMac ürünleri Bilgisayar, iPad ürünleri Tablet kategorisinde gösterilir.

### 2. Picsum Banner Görsel API'si

Ana sayfadaki banner alanında tasarımı zenginleştirmek için API key gerektirmeyen Picsum görsel API'si kullanılmıştır.

```text
https://picsum.photos/v2/list
```

Bu API yalnızca ana sayfa banner arka planı için rastgele görsel almak amacıyla kullanılmaktadır. Ürün verileriyle bağlantılı değildir.

Bu işlem şu dosya üzerinden yapılmaktadır:

```text
lib/services/background_image_api_service.dart
```

Banner görseli yüklenemezse uygulama hata vermeden kendi gradient arka plan tasarımını kullanır.

## Uygulama Özellikleri

### Ana Sayfa

Ana sayfada NovaStore Premium başlığı, dil seçimi, tema değiştirme butonu, arama alanı görünümü, API üzerinden gelen banner görseli, ürün sayısı ve sepet sayısı bilgileri yer alır.

Kullanıcı kategori chiplerine tıklayarak ürünleri filtreleyebilir. Seçilen kategoriye göre ürün listesi aynı ekranda güncellenir.

### Ürün Listeleme

Ürünler kart yapısında grid görünümüyle listelenir. Mobil ekranda iki sütunlu yapı kullanılır. Daha geniş ekranlarda ürün kartları responsive olarak ekrana uyum sağlar.

Ürün listeleme ekranında `GridView.builder` kullanılmıştır. Böylece API'den gelen ürün sayısı değişse bile liste dinamik şekilde oluşturulur.

Her ürün kartında şu bilgiler yer alır:

- Ürün görseli
- Ürün adı
- Kategori
- Fiyat
- Puan bilgisi
- Sepete eklenme durumu

### Ürün Detay Sayfası

Kullanıcı ürün kartına bastığında ürün detay ekranına yönlendirilir. Bu ekranda ürünün daha büyük görseli, adı, kategorisi, fiyatı, puanı ve açıklaması gösterilir.

Detay ekranında ürün sepete eklenebilir. Ürün zaten sepetteyse kullanıcıya bu durum gösterilir.

### Sepet Ekranı

Sepet ekranında kullanıcının eklediği ürünler listelenir. Her ürün için ürün görseli, ürün adı, kategori ve fiyat bilgisi gösterilir.

Kullanıcı sepetteki ürünleri kaldırabilir. Sepet boşsa boş sepet ekranı gösterilir. Sepette ürün varsa alt kısımda sadece `Checkout` yazan buton bulunur.

### Tema Desteği

Uygulamada gündüz ve gece modu desteği vardır. Ana ekrandaki tema butonu ile iki tema arasında geçiş yapılabilir.

Gündüz modunda açık renkli sade bir görünüm, gece modunda koyu zemin üzerine altın tonlu premium bir görünüm kullanılmıştır.

### Dil Desteği

Uygulamada Türkçe ve İngilizce dil seçimi vardır. Ana sayfadaki küçük dropdown ile dil değiştirilebilir.

Türkçe seçildiğinde uygulama metinleri Türkçe gösterilir. İngilizce seçildiğinde uygulama metinleri İngilizce gösterilir.

Dil seçimiyle birlikte kategori adları da değişir:

```text
All → Tümü
Phone → Telefon
Computer → Bilgisayar
Watch → Saat
Accessory → Aksesuar
```

Fiyat gösterimi de dile göre değişir:

```text
EN → $999
TR → 44955 TL
```

## Proje Klasör Yapısı

```text
lib/
├── data/
│   └── product_data.dart
├── models/
│   └── product.dart
├── screens/
│   ├── cart_screen.dart
│   ├── home_screen.dart
│   ├── product_detail_screen.dart
│   └── product_list_screen.dart
├── services/
│   ├── background_image_api_service.dart
│   └── product_api_service.dart
├── utils/
│   └── app_texts.dart
├── widgets/
│   └── product_card.dart
└── main.dart
```

`product_data.dart` dosyası eski demo veri yapısı için projede durmaktadır. Asıl ürün verileri API üzerinden `product_api_service.dart` dosyasıyla alınmaktadır.

Ekran görüntüleri için kullanılan klasör yapısı:

```text
screenshots/
├── added_cart.png
├── all_products.png
├── cart_screen.png
├── categories.png
├── empty_card.png
├── example_product.png
├── home_screen_cards.png
├── home_screen_en.png
├── home_screen.png
└── vscode_view.png
```

## Kullanılan Ürün Verileri

Uygulamada teknoloji ürünleri kullanılmaktadır. Ürünler WantAPI üzerinden alınır ve uygulama içinde `Product` modeline dönüştürülür.

Örnek ürün grupları:

- iPhone ürünleri
- MacBook ürünleri
- iMac
- iPad ürünleri
- Apple Watch ürünleri
- AirPods ürünleri
- HomePod ürünleri
- Apple Vision Pro

## Kurulum ve Çalıştırma

Projeyi çalıştırmak için bilgisayarda Flutter SDK ve Android Studio kurulu olmalıdır.

Önce proje klasörüne girilir:

```bash
cd novastore_catalog
```

Bağımlılıklar yüklenir:

```bash
flutter pub get
```

Uygulama çalıştırılır:

```bash
flutter run
```

Chrome üzerinde çalıştırmak için:

```bash
flutter run -d chrome
```

iPhone simulator veya Android emulator üzerinde çalıştırmak için uygun cihaz seçilerek `flutter run` komutu kullanılabilir.

## pubspec.yaml Bilgisi

Projede API istekleri için `http` paketi kullanılmaktadır.

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  http: ^1.2.2
```

Ürün görselleri API üzerinden `Image.network` ile gösterildiği için görsellerin çalışması için local asset zorunluluğu yoktur. Ancak projede yedek/demo görseller kullanılırsa `assets/images/` klasörü `pubspec.yaml` içinde tanımlanabilir.

## macOS Çalıştırma Notu

Uygulama Chrome ve mobil simulator üzerinde çalışmaktadır. macOS desktop olarak çalıştırılmak istenirse API bağlantıları için macOS network izni gerekebilir.

Bu durumda aşağıdaki dosyalarda network client izni bulunmalıdır:

```text
macos/Runner/DebugProfile.entitlements
macos/Runner/Release.entitlements
```

Gerekli izin:

```xml
<key>com.apple.security.network.client</key>
<true/>
```

Chrome veya mobil simulator üzerinde bu ek ayar gerekmez.

## Ekran Görüntüleri

Uygulamaya ait ekran görüntüleri `screenshots/` klasörü içinde tutulmuştur. Bu görseller, uygulamanın ana akışını ve temel özelliklerini göstermektedir.

### Ana Sayfa

![Ana Sayfa](screenshots/home_screen.png)

### Ana Sayfa Kart Görünümü

![Ana Sayfa Kart Görünümü](screenshots/home_screen_cards.png)

### İngilizce Görünüm

![English View](screenshots/home_screen_en.png)

### Kategori Filtreleme

![Kategori Filtreleme](screenshots/categories.png)

### Tüm Ürünler

![Tüm Ürünler](screenshots/all_products.png)

### Ürün Detayı

![Ürün Detayı](screenshots/example_product.png)

### Sepete Ürün Eklendi

![Sepete Ürün Eklendi](screenshots/added_cart.png)

### Sepet Ekranı

![Sepet Ekranı](screenshots/cart_screen.png)

### Boş Sepet Ekranı

![Boş Sepet Ekranı](screenshots/empty_card.png)

### Kod ve Proje Görünümü

![VS Code Görünümü](screenshots/vscode_view.png)

## Projede Öğrenilenler

Bu proje ile Flutter üzerinde sayfa yapısı kurma, widgetları parçalara ayırma, API'den veri çekme, JSON verisini model sınıfına dönüştürme, ürünleri GridView ile listeleme ve kullanıcı etkileşimlerine göre ekranı güncelleme konuları uygulanmıştır.

Ayrıca görsel tasarım tarafında tema rengi, kart yapısı, responsive görünüm, API görselleri, dark mode, dil seçimi ve banner görseli gibi kullanıcı deneyimini geliştiren özellikler eklenmiştir.

## Geliştirici Notu

NovaStore Catalog, temel bir e-ticaret uygulamasının sadeleştirilmiş mobil versiyonu olarak hazırlanmıştır. Projede amaç karmaşık bir alışveriş sistemi kurmak değil, Flutter ile API tabanlı katalog, detay ve sepet akışını anlaşılır şekilde göstermektir.