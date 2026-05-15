import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../models/product.dart';

class CartScreen extends StatelessWidget {
  // Sepette gösterilecek ürünler bu liste ile geliyor
  final List<Product> cartItems;

  // Ürün silme işlemi ana state üzerinden yapılıyor
  final void Function(Product product) onRemoveFromCart;

  // Sepet ekranındaki metinlerin dilini belirliyor
  final String selectedLanguage;

  const CartScreen({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.selectedLanguage,
  });

  // Dil kontrolünü daha kısa yazmak için getter kullandım
  bool get isTurkish => selectedLanguage == 'TR';

  // Sepetteki ürünlerin toplam fiyatını hesaplıyor
  double get totalPrice {
    double total = 0;
    for (final product in cartItems) {
      total += product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // Tema durumuna göre sepet ekranındaki renkleri ayarlıyorum
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = isDark ? Colors.white : const Color(0xFF111827);
    final Color mutedTextColor = isDark ? Colors.white60 : Colors.grey;

    return Scaffold(
      appBar: AppBar(
        title: Text(isTurkish ? 'Sepetim' : 'My Cart'),
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart(textColor, mutedTextColor)
          : _buildCartList(context, cardColor, textColor, mutedTextColor),
      // Sepet boş değilse alt kısımda Checkout butonu gösteriliyor
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isTurkish
                              ? 'Satın alma işlemi simüle edildi.'
                              : 'Checkout process simulated.',
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
    );
  }

  // Sepette ürün yokken gösterilen boş sepet görünümü
  Widget _buildEmptyCart(Color textColor, Color mutedTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 110,
            color: Color(0xFFC9A227),
          ),
          const SizedBox(height: 20),
          Text(
            isTurkish ? 'Sepetin boş' : 'Your cart is empty',
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isTurkish
                ? 'Ürün ekleyerek alışverişe başlayabilirsin.'
                : 'Add products to start shopping.',
            style: TextStyle(
              color: mutedTextColor,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // Sepette ürün varsa kartlar bu liste içinde gösteriliyor
  Widget _buildCartList(
    BuildContext context,
    Color cardColor,
    Color textColor,
    Color mutedTextColor,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final product = cartItems[index];

        final String priceText = _formatPrice(product.price);
        final String categoryText = _getCategoryText(product.category);

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.transparent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.07),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFFC9A227).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _buildProductImage(product),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 4),
                    Text(
                      categoryText,
                      style: TextStyle(
                        color: mutedTextColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      priceText,
                      style: const TextStyle(
                        color: Color(0xFFC9A227),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Ürün silindiğinde ana sepet listesi güncelleniyor
                  onRemoveFromCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isTurkish
                            ? '${product.name} sepetten çıkarıldı.'
                            : '${product.name} removed from cart.',
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: mutedTextColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductImage(Product product) {
    final String imageUrl = product.imageUrl.trim();

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.contain,
        // Web tarafında API görselleri canvas kaynaklı sorun çıkarırsa html image kullanıyorum
        webHtmlElementStrategy:
            kIsWeb ? WebHtmlElementStrategy.prefer : WebHtmlElementStrategy.never,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFFC9A227),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildLocalFallbackImage(product);
        },
      );
    }

    if (imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildLocalFallbackImage(product);
        },
      );
    }

    return _buildLocalFallbackImage(product);
  }

  Widget _buildLocalFallbackImage(Product product) {
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
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.image_not_supported_outlined,
          color: Color(0xFFC9A227),
          size: 32,
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
}