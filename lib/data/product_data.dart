import '../models/product.dart';

// Uygulamada gösterilecek örnek ürünleri burada sabit liste olarak tuttum
// Gerçek bir veritabanı yerine proje için yeterli olacak demo veriler kullandım

const List<Product> products = [
  // Laptop kategorisi için örnek ürün
  Product(
    id: 1,
    name: 'NovaBook Air 14',
    category: 'Laptop',
    description:
        'İnce ve hafif tasarımı, uzun pil ömrü ve güçlü performansıyla öğrenciler, ofis çalışanları ve günlük kullanıcılar için ideal bir laptop modelidir.',
    price: 28999.99,
    imagePath: 'assets/images/laptop.png',
    rating: 4.8,
  ),

  // Telefon kategorisi için örnek ürün
  Product(
    id: 2,
    name: 'NovaPhone X',
    category: 'Telefon',
    description:
        'Yüksek çözünürlüklü ekranı, hızlı işlemcisi ve gelişmiş kamera sistemiyle sosyal medya, fotoğrafçılık ve günlük kullanım için modern bir akıllı telefon deneyimi sunar.',
    price: 34999.99,
    imagePath: 'assets/images/phone.png',
    rating: 4.7,
  ),

  // Akıllı saat kategorisi için örnek ürün
  Product(
    id: 3,
    name: 'NovaWatch Fit',
    category: 'Akıllı Saat',
    description:
        'Spor takibi, nabız ölçümü, uyku analizi ve bildirim özellikleriyle günlük yaşamı kolaylaştıran şık ve kullanışlı bir akıllı saat modelidir.',
    price: 6999.99,
    imagePath: 'assets/images/watch.png',
    rating: 4.5,
  ),

  // Kulaklık kategorisi için örnek ürün
  Product(
    id: 4,
    name: 'NovaBuds Pro',
    category: 'Kulaklık',
    description:
        'Aktif gürültü engelleme, dengeli ses kalitesi ve konforlu kulak içi tasarımıyla müzik dinleme, toplantı ve oyun deneyimini üst seviyeye taşır.',
    price: 4999.99,
    imagePath: 'assets/images/earbuds.png',
    rating: 4.6,
  ),

  // Tablet kategorisi için örnek ürün
  Product(
    id: 5,
    name: 'NovaTab 11',
    category: 'Tablet',
    description:
        'Geniş ekranı, güçlü işlemcisi ve taşınabilir yapısıyla eğitim, çizim, video izleme, not alma ve günlük kullanım için uygun bir tablet seçeneğidir.',
    price: 18999.99,
    imagePath: 'assets/images/tablet.png',
    rating: 4.4,
  ),

  // Kamera kategorisi için örnek ürün
  Product(
    id: 6,
    name: 'NovaCam Mini',
    category: 'Kamera',
    description:
        'Kompakt tasarımı, kolay taşınabilir gövdesi ve pratik çekim modları sayesinde vlog, seyahat ve günlük video çekimleri için kullanılabilecek kullanışlı bir kameradır.',
    price: 12999.99,
    imagePath: 'assets/images/camera.png',
    rating: 4.3,
  ),

  // Aksesuar kategorisi için klavye ürünü
  Product(
    id: 7,
    name: 'NovaPad Keyboard',
    category: 'Aksesuar',
    description:
        'Tablet ve bilgisayarlarla uyumlu, hafif ve kompakt yapıya sahip kablosuz klavye. Ders notları, rapor hazırlama ve ofis işleri için pratik kullanım sunar.',
    price: 2499.99,
    imagePath: 'assets/images/keyboard.png',
    rating: 4.2,
  ),

  // Aksesuar kategorisi için taşınabilir şarj ürünü
  Product(
    id: 8,
    name: 'NovaPower 20K',
    category: 'Aksesuar',
    description:
        '20000 mAh kapasitesiyle telefon, tablet ve kulaklık gibi cihazları gün içinde tekrar şarj edebilen taşınabilir güç bankasıdır.',
    price: 1799.99,
    imagePath: 'assets/images/powerbank.png',
    rating: 4.6,
  ),
];