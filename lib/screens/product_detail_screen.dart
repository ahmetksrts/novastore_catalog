import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

    final String priceText = _formatPrice(product.price);
    final String categoryText = _getCategoryText(product.category);
    final String descriptionText = _getDescriptionText(
      product.name,
      product.description,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isTurkish ? 'Ürün Detayı' : 'Product Detail'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWideScreen = constraints.maxWidth >= 850;
          final double maxContentWidth = isWideScreen ? 1180 : double.infinity;
          final double imagePanelHeight = isWideScreen ? 430 : 320;
          final double imageBoxSize = isWideScreen ? 340 : 240;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Detay ekranında ürünün gerçek görselini daha geniş bir alanda gösteriyorum
                  Container(
                    height: imagePanelHeight,
                    color: cardColor,
                    child: Center(
                      child: Container(
                        width: imageBoxSize,
                        height: imageBoxSize,
                        padding: EdgeInsets.all(isWideScreen ? 22 : 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC9A227).withAlpha(22),
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: _buildProductImage(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWideScreen ? 34 : 22,
                      vertical: 22,
                    ),
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
            ),
          );
        },
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

  Widget _buildProductImage() {
    final String imageUrl = product.imageUrl.trim();

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        // Web tarafında API görselleri canvas kaynaklı sorun çıkarırsa html image kullanıyorum
        webHtmlElementStrategy:
            kIsWeb ? WebHtmlElementStrategy.prefer : WebHtmlElementStrategy.never,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: Color(0xFFC9A227),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildLocalFallbackImage();
        },
      );
    }

    if (imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildLocalFallbackImage();
        },
      );
    }

    return _buildLocalFallbackImage();
  }

  Widget _buildLocalFallbackImage() {
    final String category = product.category.toLowerCase();
    final String name = product.name.toLowerCase();

    String assetPath = 'assets/images/phone.png';

    if (category.contains('computer') ||
        category.contains('laptop') ||
        name.contains('macbook') ||
        name.contains('imac')) {
      assetPath = 'assets/images/laptop.png';
    } else if (category.contains('tablet') || name.contains('ipad')) {
      assetPath = 'assets/images/tablet.png';
    } else if (category.contains('watch') || name.contains('watch')) {
      assetPath = 'assets/images/watch.png';
    } else if (name.contains('airpods') ||
        name.contains('homepod') ||
        category.contains('accessory')) {
      assetPath = 'assets/images/earbuds.png';
    } else if (name.contains('camera')) {
      assetPath = 'assets/images/camera.png';
    }

    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          color: Color(0xFFC9A227),
          size: 70,
        );
      },
    );
  }

  // API fiyatı USD geldiği için TR görünümde 45 ile çarpıp TL gösteriyorum
  String _formatPrice(double dollarPrice) {
    if (isTurkish) {
      final int turkishPrice = (dollarPrice * 45).round();
      return '$turkishPrice TL';
    }

    return '\$${dollarPrice.toStringAsFixed(0)}';
  }

  // Kategori metnini seçilen dile göre düzenliyorum
  String _getCategoryText(String category) {
    if (!isTurkish) {
      return category;
    }

    switch (category.toLowerCase()) {
      case 'phone':
      case 'smartphones':
        return 'Telefon';
      case 'computer':
      case 'laptop':
      case 'laptops':
        return 'Bilgisayar';
      case 'tablet':
        return 'Tablet';
      case 'watch':
        return 'Saat';
      case 'accessory':
      case 'electronics':
      case 'technology':
      case 'jewelery':
      case 'jewelry':
        return 'Aksesuar';
      case "men's clothing":
        return 'Erkek Giyim';
      case "women's clothing":
        return 'Kadın Giyim';
      default:
        return category;
    }
  }

  // API'den gelen açıklamayı seçilen dile göre kullanıyorum
  String _getDescriptionText(String productName, String fallbackDescription) {
    return fallbackDescription;
  }
}