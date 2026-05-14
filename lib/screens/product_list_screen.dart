import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  // Tüm ürünler ekranında sepet durumunu göstermek için bu listeyi alıyorum
  final List<Product> cartItems;

  // Ürün detayından sepete ekleme yapılabilmesi için callback olarak geliyor
  final void Function(Product product) onAddToCart;

  // Sepet ekranına geçildiğinde ürün silme işlemi için kullanılıyor
  final void Function(Product product) onRemoveFromCart;

  // Bu ekranın hangi dilde gösterileceğini belirliyor
  final String selectedLanguage;

  const ProductListScreen({
    super.key,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.selectedLanguage,
  });

  // Dil kontrolünü daha okunabilir yapmak için getter kullandım
  bool get isTurkish => selectedLanguage == 'TR';

  @override
  Widget build(BuildContext context) {
    // Tema durumuna göre ürün listesi ekranındaki renkleri ayarlıyorum
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = isDark ? Colors.white : const Color(0xFF111827);
    final Color mutedTextColor = isDark ? Colors.white60 : Colors.grey;
    final Color pageBackground =
        isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(isTurkish ? 'Ürünler' : 'Products'),
        actions: [
          IconButton(
            onPressed: () {
              // Sağ üstteki ikon ile sepet ekranına geçiliyor
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: cartItems,
                    onRemoveFromCart: onRemoveFromCart,
                    selectedLanguage: selectedLanguage,
                  ),
                ),
              );
            },
            icon: Badge(
              isLabelVisible: cartItems.isNotEmpty,
              label: Text(cartItems.length.toString()),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final bool isDesktop = screenWidth >= 1000;
            final bool isTablet = screenWidth >= 700 && screenWidth < 1000;
            final int productColumnCount = isDesktop ? 4 : (isTablet ? 3 : 2);
            final double horizontalPadding = isDesktop ? 28 : 16;
            final double productCardHeight = isDesktop ? 286 : 235;

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        16,
                        horizontalPadding,
                        10,
                      ),
                      child: Text(
                        isTurkish
                            ? 'Tüm NovaStore ürünlerini incele.'
                            : 'Explore all NovaStore products.',
                        style: TextStyle(
                          color: mutedTextColor,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    // Ürünleri ekran genişliğine göre değişen kolon sayısıyla gösteriyorum
                    Expanded(
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          10,
                          horizontalPadding,
                          40,
                        ),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: products.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: productColumnCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: productCardHeight,
                        ),
                        itemBuilder: (context, index) {
                          // Her ürün için ortak kart widgetını kullanıyorum
                          return ProductCard(
                            product: products[index],
                            cartItems: cartItems,
                            onAddToCart: onAddToCart,
                            selectedLanguage: selectedLanguage,
                            cardColor: cardColor,
                            textColor: textColor,
                            mutedTextColor: mutedTextColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}