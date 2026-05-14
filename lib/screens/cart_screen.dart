import 'package:flutter/material.dart';

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

        // İngilizce dilinde fiyatı TL değerinden dolara çeviriyorum
        final int dollarPrice = (product.price / 45).round();
        final String priceText = isTurkish
            ? '${product.price.toStringAsFixed(0)} TL'
            : '\$$dollarPrice';

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
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.contain,
                ),
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
}