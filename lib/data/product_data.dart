import '../models/product.dart';

// API bağlantısında sorun olursa kullanılabilecek yedek ürün listesi
// Normal akışta ürünler product_api_service.dart üzerinden alınır

const List<Product> products = [
  Product(
    id: 1,
    name: 'NovaBook Air 14',
    category: 'Computer',
    description:
        'İnce gövdeli, hafif ve günlük kullanıma uygun bir laptop modeli. Ders, ofis işleri ve temel tasarım çalışmaları için yeterli performans sunar.',
    price: 1299,
    imageUrl: 'https://wantapi.com/assets/images/macbook_air.png',
    rating: 4.8,
  ),
  Product(
    id: 2,
    name: 'NovaPhone X',
    category: 'Phone',
    description:
        'Geniş ekranı, güçlü işlemcisi ve gelişmiş kamera özellikleriyle günlük kullanım için hazırlanmış modern bir akıllı telefon modelidir.',
    price: 999,
    imageUrl: 'https://wantapi.com/assets/images/iphone.png',
    rating: 4.7,
  ),
  Product(
    id: 3,
    name: 'NovaWatch Fit',
    category: 'Watch',
    description:
        'Spor takibi, bildirimler ve sağlık ölçümleri için kullanılabilecek sade ve pratik bir akıllı saat seçeneğidir.',
    price: 399,
    imageUrl: 'https://wantapi.com/assets/images/watch.png',
    rating: 4.5,
  ),
  Product(
    id: 4,
    name: 'NovaBuds Pro',
    category: 'Accessory',
    description:
        'Gürültü engelleme desteği ve dengeli ses yapısıyla müzik, toplantı ve günlük kullanım için uygun kablosuz kulaklık modelidir.',
    price: 249,
    imageUrl: 'https://wantapi.com/assets/images/airpods.png',
    rating: 4.6,
  ),
  Product(
    id: 5,
    name: 'NovaTab 11',
    category: 'Tablet',
    description:
        'Not alma, video izleme, çizim yapma ve taşınabilir çalışma düzeni için kullanılabilecek geniş ekranlı tablet modelidir.',
    price: 599,
    imageUrl: 'https://wantapi.com/assets/images/ipad.png',
    rating: 4.4,
  ),
  Product(
    id: 6,
    name: 'Nova Vision Mini',
    category: 'Accessory',
    description:
        'Yeni nesil teknoloji ürünlerini temsil eden, katalog içinde farklı ürün çeşidi göstermek için eklenmiş örnek cihazdır.',
    price: 3499,
    imageUrl: 'https://wantapi.com/assets/images/vision_pro.png',
    rating: 4.3,
  ),
  Product(
    id: 7,
    name: 'Nova iMac Studio',
    category: 'Computer',
    description:
        'Masaüstü kullanım için tasarlanmış, geniş ekranlı ve güçlü donanımlı örnek bilgisayar ürünüdür.',
    price: 1299,
    imageUrl: 'https://wantapi.com/assets/images/imac.png',
    rating: 4.2,
  ),
  Product(
    id: 8,
    name: 'Nova Home Speaker',
    category: 'Accessory',
    description:
        'Ev ve çalışma alanı için kullanılabilecek kompakt yapılı, şık görünümlü akıllı hoparlör modelidir.',
    price: 299,
    imageUrl: 'https://wantapi.com/assets/images/homepod.png',
    rating: 4.6,
  ),
];