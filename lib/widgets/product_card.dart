import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  // Bu widget tek bir ürün kartını temsil ediyor
  final Product product;

  // Ürünün sepette olup olmadığını kontrol etmek için sepet listesini alıyorum
  final List<Product> cartItems;
  final void Function(Product product) onAddToCart;

  // Dil ve tema renkleri ana ekrandan gönderiliyor
  final String selectedLanguage;
  final Color cardColor;
  final Color textColor;
  final Color mutedTextColor;

  const ProductCard({
    super.key,
    required this.product,
    required this.cartItems,
    required this.onAddToCart,
    required this.selectedLanguage,
    required this.cardColor,
    required this.textColor,
    required this.mutedTextColor,
  });

  // Metinlerin hangi dilde gösterileceğini buradan kontrol ediyorum
  bool get isTurkish => selectedLanguage == 'TR';

  @override
  Widget build(BuildContext context) {
    final bool isInCart = cartItems.contains(product);

    // İngilizce görünümde fiyatı sabit kur üzerinden dolara çeviriyorum
    final int dollarPrice = (product.price / 45).round();
    final String priceText = isTurkish
        ? '${product.price.toStringAsFixed(0)} TL'
        : '\$$dollarPrice';

    final String categoryText = _getCategoryText(product.category);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // Karta basıldığında ürün bilgisi detay sayfasına taşınıyor
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
              isInCart: isInCart,
              onAddToCart: onAddToCart,
              selectedLanguage: selectedLanguage,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white10
                : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  isInCart ? Icons.check_circle : Icons.favorite_border,
                  size: 22,
                  color: isInCart ? const Color(0xFFC9A227) : mutedTextColor,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Container(
                  width: 92,
                  height: 78,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9A227).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                categoryText,
                style: TextStyle(
                  color: mutedTextColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      priceText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC9A227),
                      ),
                    ),
                  ),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 3),
                  Text(
                    product.rating.toString(),
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kategori adını seçilen dile göre gösteriyorum
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
}