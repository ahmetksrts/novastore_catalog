import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  // Detay sayfasında gösterilecek ürün bilgisi
  final Product product;

  // Butonun durumunu belirlemek için ürünün sepette olup olmadığını alıyorum
  final bool isInCart;
  final void Function(Product product) onAddToCart;

  // Sayfadaki metinlerin TR veya EN olmasını bu değişken belirliyor
  final String selectedLanguage;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isInCart,
    required this.onAddToCart,
    required this.selectedLanguage,
  });

  // Dil kontrolünü daha okunabilir yapmak için getter kullandım
  bool get isTurkish => selectedLanguage == 'TR';

  @override
  Widget build(BuildContext context) {
    // Tema seçimine göre detay ekranındaki renkleri belirliyorum
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark ? Colors.white : const Color(0xFF111827);
    final Color mutedTextColor = isDark ? Colors.white60 : Colors.grey;
    final Color cardColor = Theme.of(context).cardColor;

    // İngilizce görünümde TL fiyatını sabit kurla dolara çeviriyorum
    final int dollarPrice = (product.price / 45).round();
    final String priceText = isTurkish
        ? '${product.price.toStringAsFixed(0)} TL'
        : '\$$dollarPrice';

    final String categoryText = _getCategoryText(product.category);
    final String descriptionText = _getDescriptionText(
      product.name,
      product.description,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Detay ekranında ürünün gerçek görselini gösteriyorum
          Container(
            height: 300,
            color: cardColor,
            child: Center(
              child: Container(
                width: 220,
                height: 220,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9A227).withAlpha(22),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  categoryText,
                  style: TextStyle(
                    color: mutedTextColor,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 6),
                    Text(
                      product.rating.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      priceText,
                      style: const TextStyle(
                        color: Color(0xFFC9A227),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  isTurkish ? 'Açıklama' : 'Description',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descriptionText,
                  style: TextStyle(
                    fontSize: 15.5,
                    height: 1.5,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  isTurkish ? 'Özellikler' : 'Specifications',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Özellik kutuları ekran genişliğine göre alta kayabilsin diye Wrap kullandım
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _specBox(
                      context,
                      isTurkish ? 'KATEGORİ' : 'CATEGORY',
                      categoryText,
                    ),
                    _specBox(
                      context,
                      isTurkish ? 'PUAN' : 'RATING',
                      product.rating.toString(),
                    ),
                    _specBox(
                      context,
                      isTurkish ? 'FİYAT' : 'PRICE',
                      priceText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(31),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          height: 54,
          child: ElevatedButton.icon(
            onPressed: isInCart
                ? null
                : () {
                    // Sepete ekleme işlemi main.dart tarafındaki state üzerinde yapılıyor
                    onAddToCart(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isTurkish
                              ? '${product.name} sepete eklendi.'
                              : '${product.name} added to cart.',
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  },
            icon: Icon(
              isInCart ? Icons.check_circle : Icons.add_shopping_cart,
            ),
            label: Text(
              isInCart
                  ? (isTurkish ? 'Sepette Var' : 'Already in Cart')
                  : (isTurkish ? 'Sepete Ekle' : 'Add to Cart'),
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  // Detay ekranındaki küçük özellik kutularını bu yardımcı widget oluşturuyor
  Widget _specBox(BuildContext context, String title, String value) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111827) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.transparent,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white60 : Colors.grey,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF111827),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Kategori metnini seçilen dile göre düzenliyorum
  String _getCategoryText(String category) {
    if (isTurkish) {
      return category;
    }

    switch (category) {
      case 'Telefon':
        return 'Phone';
      case 'Akıllı Saat':
        return 'Smart Watch';
      case 'Kulaklık':
        return 'Headphones';
      case 'Kamera':
        return 'Camera';
      case 'Aksesuar':
        return 'Accessory';
      default:
        return category;
    }
  }

  // Ürün açıklamasını seçilen dile göre döndürüyorum
  String _getDescriptionText(String productName, String fallbackDescription) {
    if (isTurkish) {
      return fallbackDescription;
    }

    switch (productName) {
      case 'NovaBook Air 14':
        return 'A slim and lightweight laptop with long battery life and strong performance. It is ideal for students, office workers, and daily users.';
      case 'NovaPhone X':
        return 'A modern smartphone experience with a high-resolution display, fast processor, and advanced camera system for social media, photography, and daily use.';
      case 'NovaWatch Fit':
        return 'A stylish and practical smart watch with sport tracking, heart rate monitoring, sleep analysis, and notification features.';
      case 'NovaBuds Pro':
        return 'Wireless earbuds with active noise cancellation, balanced sound quality, and a comfortable in-ear design for music, meetings, and gaming.';
      case 'NovaTab 11':
        return 'A portable tablet with a large display and strong performance for education, drawing, video watching, note taking, and daily use.';
      case 'NovaCam Mini':
        return 'A compact camera with easy portability and practical shooting modes for vlogs, travel, and daily video recording.';
      case 'NovaPad Keyboard':
        return 'A lightweight wireless keyboard compatible with tablets and computers. It is useful for notes, reports, and office work.';
      case 'NovaPower 20K':
        return 'A 20000 mAh power bank that can recharge phones, tablets, and earbuds throughout the day.';
      default:
        return fallbackDescription;
    }
  }
}