class Product {
  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  // Önceki dosyalarda imagePath kullanımı kaldıysa aynı görsel adresini döndürür
  String get imagePath => imageUrl;

  factory Product.fromJson(Map<String, dynamic> json) {
    final String productName = _readString(
      json['name'] ?? json['title'],
      'Unnamed Product',
    );

    final String imageValue = _readString(
      json['image'] ?? json['thumbnail'] ?? json['imagePath'] ?? json['imageUrl'],
      '',
    );

    return Product(
      id: _readInt(json['id']),
      name: productName,
      category: _detectCategory(productName),
      description: _readString(
        json['description'] ?? json['tagline'],
        'No description available',
      ),
      price: _readPrice(json['price']),
      imageUrl: _normalizeImageUrl(imageValue),
      rating: _readDouble(json['rating'], fallback: 4.5),
    );
  }

  static String _normalizeImageUrl(String value) {
    final String image = value.trim();

    if (image.isEmpty) {
      return '';
    }

    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }

    if (image.startsWith('//')) {
      return 'https:$image';
    }

    if (image.startsWith('/')) {
      return 'https://wantapi.com$image';
    }

    return image;
  }

  static double _readPrice(dynamic value, {double fallback = 0}) {
    if (value is num) {
      return value.toDouble();
    }

    if (value == null) {
      return fallback;
    }

    final String cleanedValue = value
        .toString()
        .replaceAll('\$', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(cleanedValue) ?? fallback;
  }

  // API kategori göndermediği için basit bir ürün adı kontrolü yeterli oluyor
  static String _detectCategory(String name) {
    final String lowerName = name.toLowerCase();

    if (lowerName.contains('iphone')) {
      return 'Phone';
    }

    if (lowerName.contains('macbook') || lowerName.contains('imac')) {
      return 'Computer';
    }

    if (lowerName.contains('ipad')) {
      return 'Tablet';
    }

    if (lowerName.contains('watch')) {
      return 'Watch';
    }

    if (lowerName.contains('airpods') ||
        lowerName.contains('homepod') ||
        lowerName.contains('vision')) {
      return 'Accessory';
    }

    return 'Technology';
  }

  static int _readInt(dynamic value, {int fallback = 0}) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    if (value == null) {
      return fallback;
    }

    return int.tryParse(value.toString()) ?? fallback;
  }

  static double _readDouble(dynamic value, {double fallback = 0}) {
    if (value is double) {
      return value;
    }

    if (value is num) {
      return value.toDouble();
    }

    if (value == null) {
      return fallback;
    }

    final String cleanedValue = value
        .toString()
        .replaceAll('\$', '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(cleanedValue) ?? fallback;
  }

  static String _readString(dynamic value, String fallback) {
    if (value == null) {
      return fallback;
    }

    final String text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}