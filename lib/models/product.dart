class Product {
  // Ürünleri birbirinden ayırmak için benzersiz id kullanıyorum
  final int id;

  // Kart ve detay ekranında gösterilen temel ürün bilgileri
  final String name;
  final String category;
  final String description;

  // Fiyat TL olarak tutuluyor
  final double price;

  // Asset görsel yolu için alan bıraktım
  final String imagePath;

  // Ürün puanı kartlarda ve detay ekranında gösteriliyor
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.rating,
  });

  @override
  bool operator ==(Object other) {
    // Sepet işlemlerinde aynı ürünü id değerine göre kontrol ediyorum
    return identical(this, other) ||
        other is Product && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}