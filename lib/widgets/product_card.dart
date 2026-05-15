import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/product.dart';
import '../screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  final List<Product> cartItems;
  final void Function(Product product) onAddToCart;

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

  bool get isTurkish => selectedLanguage == 'TR';

  @override
  Widget build(BuildContext context) {
    final bool isInCart = cartItems.contains(product);

    final String priceText = _formatPrice(product.price);
    final String categoryText = _getCategoryText(product.category);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
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
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  isInCart ? Icons.check_circle : Icons.favorite_border,
                  size: 24,
                  color: isInCart ? const Color(0xFFC9A227) : mutedTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Center(
                  child: Container(
                    width: 168,
                    height: 142,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC9A227).withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: const Color(0xFFC9A227).withValues(alpha: 0.10),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _buildProductImage(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                categoryText,
                style: TextStyle(
                  color: mutedTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      priceText,
                      style: const TextStyle(
                        fontSize: 16,
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

  Widget _buildProductImage() {
    final String imageUrl = product.imageUrl.trim();

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        webHtmlElementStrategy: kIsWeb
            ? WebHtmlElementStrategy.prefer
            : WebHtmlElementStrategy.never,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
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
        width: double.infinity,
        height: double.infinity,
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
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          color: Color(0xFFC9A227),
          size: 34,
        );
      },
    );
  }

  String _formatPrice(double dollarPrice) {
    if (isTurkish) {
      final int priceAsTl = (dollarPrice * 45).round();
      return '$priceAsTl TL';
    }

    return '\$${dollarPrice.toStringAsFixed(0)}';
  }

  String _getCategoryText(String category) {
    final String value = category.toLowerCase();

    if (!isTurkish) {
      return category;
    }

    if (value == 'phone' || value == 'smartphones') {
      return 'Telefon';
    }

    if (value == 'computer' || value == 'laptop' || value == 'laptops') {
      return 'Bilgisayar';
    }

    if (value == 'watch') {
      return 'Saat';
    }

    if (value == 'accessory' ||
        value == 'electronics' ||
        value == 'technology') {
      return 'Aksesuar';
    }

    return category;
  }
}