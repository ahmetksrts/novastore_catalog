# NovaStore Catalog

NovaStore Catalog, Flutter ile geliştirilmiş basit ama görsel olarak düzenli bir mini e-ticaret katalog uygulamasıdır. Uygulamada teknoloji ürünleri listelenir, ürün detayları görüntülenir ve ürünler sepete eklenip sepetten çıkarılabilir.

Bu proje, mobil uygulama geliştirme sürecinde temel Flutter yapısını, ekranlar arası geçişleri, kart tabanlı listelemeyi, tema kullanımını, asset yönetimini ve basit state mantığını göstermek amacıyla hazırlanmıştır.

## Proje Amacı

Bu uygulamanın amacı, bir e-ticaret uygulamasının temel katalog yapısını küçük ölçekte simüle etmektir. Kullanıcı ana ekranda ürünleri görebilir, kategoriye göre filtreleme yapabilir, ürün detayına geçebilir ve istediği ürünleri sepete ekleyebilir.

Projede özellikle şu konular uygulanmıştır:

- Flutter proje yapısı
- StatelessWidget ve StatefulWidget kullanımı
- Navigator ile sayfalar arası geçiş
- GridView ile ürün kartlarının listelenmesi
- Ürün modeli oluşturma
- Demo ürün verisi kullanma
- Sepet işlemleri için basit state yönetimi
- Light ve Dark tema desteği
- Türkçe ve İngilizce dil seçimi
- Asset klasöründen PNG görsel kullanımı

## Kullanılanlar

- Flutter 3.41.9
- Dart 3.11.5
- DevTools 2.54.2
- Material Design
- Android Studio
- Android language: Kotlin
- Local asset image kullanımı

Ekstra bir backend, veritabanı ya da karmaşık state management paketi kullanılmamıştır. Proje, eğitim kapsamında temel Flutter bilgilerini gösterecek şekilde sade tutulmuştur.

Proje geliştirilirken kullanılan Flutter ve Android ortamı:

```text
Flutter 3.41.9 • channel stable
Dart 3.11.5
DevTools 2.54.2
```

## Uygulama Özellikleri

### Ana Sayfa

Ana sayfada NovaStore Premium başlığı, dil seçimi, tema değiştirme butonu, arama alanı görünümü, kısa tanıtım bannerı, ürün ve sepet sayısı bilgileri yer alır.

Kullanıcı bu ekranda kategori chiplerine tıklayarak ürünleri filtreleyebilir. Seçilen kategoriye göre ürün listesi aynı ekranda güncellenir.

### Ürün Listeleme

Ürünler kart yapısında grid görünümüyle listelenir. Mobil ekranda iki sütunlu, geniş ekranlarda ise daha fazla sütunlu responsive yapı kullanılmıştır. Her ürün kartında ürün görseli, ürün adı, kategori, fiyat ve puan bilgisi bulunur.

Ürün listeleme ekranında `GridView.builder` kullanılmıştır. Böylece ürün sayısı artsa bile liste dinamik olarak oluşturulabilir.

### Ürün Detay Sayfası

Kullanıcı bir ürün kartına bastığında ürün detay ekranına yönlendirilir. Bu ekranda ürünün daha büyük görseli, adı, kategorisi, fiyatı, puanı, açıklaması ve temel özellikleri gösterilir.

Detay ekranında ürün sepete eklenebilir. Ürün zaten sepetteyse buton pasifleşir ve kullanıcıya ürünün sepette olduğu gösterilir.

### Sepet Ekranı

Sepet ekranında kullanıcının eklediği ürünler listelenir. Her ürün için küçük ürün görseli, ürün adı, kategori ve fiyat bilgisi gösterilir.

Kullanıcı sepetteki ürünleri kaldırabilir. Sepet boşsa kullanıcıya boş sepet ekranı gösterilir. Sepette ürün varsa alt kısımda sadece `Checkout` yazan bir buton bulunur.

### Tema Desteği

Uygulamada gündüz ve gece modu desteği vardır. Ana ekrandaki tema butonu ile iki tema arasında geçiş yapılabilir.

Gündüz modunda açık renkli sade bir görünüm, gece modunda ise koyu zemin üzerine altın tonlu premium bir görünüm kullanılmıştır.

### Dil Desteği

Uygulamada Türkçe ve İngilizce dil seçimi vardır. Ana sayfadaki küçük dropdown ile dil değiştirilebilir.

Türkçe seçildiğinde uygulama metinleri Türkçe gösterilir. İngilizce seçildiğinde başlıklar, açıklamalar, kategori adları ve bilgilendirme mesajları İngilizce gösterilir.

Fiyatlar Türkçe modda TL olarak gösterilir. İngilizce modda fiyatlar sabit kur mantığıyla dolara çevrilir. Projede örnek hesaplama için 1 dolar = 45 TL kabul edilmiştir.

Örnek:

```text
2500 TL / 45 ≈ $56
```

## API Kullanımı Hakkında

Bu projede gerçek bir API bağlantısı kullanılmamıştır. Ürün verileri `lib/data/product_data.dart` dosyasında sabit demo veri olarak tutulmuştur.

Proje yönergesinde API ve JSON yapısından bahsedilmesinin temel amacı, dış kaynaktan veri alma mantığını ve modelleme yapısını öğretmektir. Bu projede bu mantık yerel veri ile simüle edilmiştir.

Yani uygulamada:

- Gerçek backend bağlantısı yoktur
- HTTP isteği yapılmamaktadır
- Ürünler yerel demo listeden okunmaktadır
- `Product` modeli ile veri yapısı temsil edilmektedir
- Veriler arayüzde dinamik olarak listelenmektedir

Bu tercih, projeyi daha sade ve eğitim kapsamına uygun tutmak için yapılmıştır.

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
├── utils/
│   └── app_texts.dart
├── widgets/
│   └── product_card.dart
└── main.dart
```

Görseller için kullanılan klasör yapısı:

```text
assets/
└── images/
    ├── laptop.png
    ├── phone.png
    ├── watch.png
    ├── earbuds.png
    ├── tablet.png
    ├── camera.png
    ├── keyboard.png
    └── powerbank.png
```

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

Uygulamada örnek olarak teknoloji ürünleri kullanılmıştır. Ürünlerin adı, kategorisi, açıklaması, fiyatı, görsel yolu ve puan bilgisi bulunmaktadır.

Örnek ürün kategorileri:

- Laptop
- Telefon
- Akıllı Saat
- Kulaklık
- Tablet
- Kamera
- Aksesuar

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

Android Studio üzerinden çalıştırmak için proje açıldıktan sonra uygun cihaz veya emulator seçilir ve Run butonuna basılır.

## pubspec.yaml Asset Ayarı

Ürün görsellerinin çalışması için `pubspec.yaml` dosyasında asset klasörü tanımlanmıştır.

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/images/
```

Bu ayar yapılmazsa ürün görselleri ekranda görünmez.


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

Bu proje ile Flutter üzerinde sayfa yapısı kurma, widgetları parçalara ayırma, ürün modeli oluşturma, demo veri kullanma ve kullanıcı etkileşimlerine göre ekranı güncelleme konuları uygulanmıştır.

Ayrıca görsel tasarım tarafında tema rengi, kart yapısı, grid görünüm, ürün görselleri, dark mode ve dil seçimi gibi kullanıcı deneyimini geliştiren ek özellikler eklenmiştir.

## Geliştirici Notu

NovaStore Catalog, temel bir e-ticaret uygulamasının sadeleştirilmiş mobil versiyonu olarak hazırlanmıştır. Projede amaç karmaşık bir alışveriş sistemi kurmak değil, Flutter ile katalog, detay ve sepet akışını anlaşılır şekilde göstermektir.