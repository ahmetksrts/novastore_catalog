import '../models/product.dart';
import '../widgets/product_card.dart';
import '../services/background_image_api_service.dart';
import '../utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Product> products;
  final List<Product> cartItems;
  final void Function(Product product) onAddToCart;
  final void Function(Product product) onRemoveFromCart;
  final bool isDarkMode;
  final void Function(bool value) onThemeChanged;
  final String selectedLanguage;
  final void Function(String language) onLanguageChanged;

  const HomeScreen({
    super.key,
    required this.products,
    required this.cartItems,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  int bannerRefreshKey = 0;

  final BackgroundImageApiService backgroundImageApiService =
      BackgroundImageApiService();

  bool get isTurkish => widget.selectedLanguage == 'TR';

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return widget.products;
    }
    return widget.products.where((product) {
      return product.category == selectedCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = isDark ? Colors.white : const Color(0xFF111827);
    final Color mutedTextColor = isDark ? Colors.white60 : Colors.grey;
    final Color pageBackground =
        isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC);
    final Color softBackground =
        isDark ? const Color(0xFF111827) : const Color(0xFFF1F5F9);

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(isTurkish ? 'Keşfet' : 'Discover'),
        actions: [
          IconButton(
            onPressed: () {
              _refreshBanner();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: widget.cartItems,
                    onRemoveFromCart: widget.onRemoveFromCart,
                    selectedLanguage: widget.selectedLanguage,
                  ),
                ),
              );
            },
            icon: Badge(
              isLabelVisible: widget.cartItems.isNotEmpty,
              label: Text(widget.cartItems.length.toString()),
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
            final double horizontalPadding = isDesktop ? 28 : 18;
            final double productCardHeight = isDesktop ? 286 : 272;

            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: ListView(
                  padding: EdgeInsets.all(horizontalPadding),
                  children: [
                    isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  children: [
                                    _buildTopBar(textColor, mutedTextColor),
                                    const SizedBox(height: 18),
                                    _buildSearchBox(softBackground, mutedTextColor, isDark),
                                    const SizedBox(height: 18),
                                    _buildHeroBanner(isDesktop: true),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    _buildInfoCard(
                                      context,
                                      icon: Icons.inventory_2_outlined,
                                      title: widget.products.length.toString(),
                                      subtitle: isTurkish ? 'Ürün' : 'Products',
                                    ),
                                    const SizedBox(height: 14),
                                    _buildInfoCard(
                                      context,
                                      icon: Icons.shopping_bag_outlined,
                                      title: widget.cartItems.length.toString(),
                                      subtitle: isTurkish ? 'Sepette' : 'In Cart',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              _buildTopBar(textColor, mutedTextColor),
                              const SizedBox(height: 18),
                              _buildSearchBox(softBackground, mutedTextColor, isDark),
                              const SizedBox(height: 18),
                              _buildHeroBanner(isDesktop: false),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoCard(
                                      context,
                                      icon: Icons.inventory_2_outlined,
                                      title: widget.products.length.toString(),
                                      subtitle: isTurkish ? 'Ürün' : 'Products',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildInfoCard(
                                      context,
                                      icon: Icons.shopping_bag_outlined,
                                      title: widget.cartItems.length.toString(),
                                      subtitle: isTurkish ? 'Sepette' : 'In Cart',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(height: 20),
                    _buildCategoryList(),
                    const SizedBox(height: 22),
                    _buildSectionHeader(textColor),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: productColumnCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: productCardHeight,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredProducts[index],
                          cartItems: widget.cartItems,
                          onAddToCart: widget.onAddToCart,
                          selectedLanguage: widget.selectedLanguage,
                          cardColor: cardColor,
                          textColor: textColor,
                          mutedTextColor: mutedTextColor,
                        );
                      },
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

  Widget _buildTopBar(Color textColor, Color mutedTextColor) {
    return Row(
      children: [
        Expanded(
          child: _buildPremiumHeader(textColor, mutedTextColor),
        ),
        const SizedBox(width: 10),
        _buildLanguageDropdown(),
        const SizedBox(width: 8),
        _buildThemeButton(),
      ],
    );
  }

  Widget _buildSearchBox(
    Color softBackground,
    Color mutedTextColor,
    bool isDark,
  ) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: softBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: mutedTextColor),
          const SizedBox(width: 10),
          Text(
            isTurkish ? 'Ürünlerde ara' : 'Search products',
            style: TextStyle(color: mutedTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedCategory == 'All'
              ? (isTurkish ? 'Öne Çıkanlar' : 'Featured Picks')
              : AppTexts.category(selectedCategory, widget.selectedLanguage),
          style: TextStyle(
            color: textColor,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            _refreshBanner();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductListScreen(
                  products: widget.products,
                  cartItems: widget.cartItems,
                  onAddToCart: widget.onAddToCart,
                  onRemoveFromCart: widget.onRemoveFromCart,
                  selectedLanguage: widget.selectedLanguage,
                ),
              ),
            );
          },
          child: Text(
            isTurkish ? 'Tümünü gör' : 'See all',
            style: const TextStyle(
              color: Color(0xFFC9A227),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    final List<String> categories = widget.products
        .map((product) => product.category)
        .where((category) => category.trim().isNotEmpty)
        .toSet()
        .toList();

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip(
            label: AppTexts.category('All', widget.selectedLanguage),
            value: 'All',
          ),
          ...categories.map((category) {
            return _buildCategoryChip(
              label: AppTexts.category(category, widget.selectedLanguage),
              value: category,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPremiumHeader(Color textColor, Color mutedTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NovaStore Premium',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          isTurkish
              ? 'Akıllı alışveriş deneyimi'
              : 'Smart shopping experience',
          style: TextStyle(
            color: mutedTextColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF111827)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: widget.isDarkMode ? Colors.white10 : Colors.transparent,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedLanguage,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          borderRadius: BorderRadius.circular(14),
          dropdownColor:
              widget.isDarkMode ? const Color(0xFF111827) : Colors.white,
          items: const [
            DropdownMenuItem(value: 'TR', child: Text('TR')),
            DropdownMenuItem(value: 'EN', child: Text('EN')),
          ],
          onChanged: (value) {
            if (value != null) {
              _refreshBanner();
              widget.onLanguageChanged(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildThemeButton() {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF111827)
            : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: widget.isDarkMode ? Colors.white10 : Colors.transparent,
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          _refreshBanner();
          widget.onThemeChanged(!widget.isDarkMode);
        },
        icon: Icon(
          widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: const Color(0xFFC9A227),
          size: 21,
        ),
      ),
    );
  }

  Widget _buildHeroBanner({required bool isDesktop}) {
    return FutureBuilder<String?>(
      key: ValueKey(bannerRefreshKey),
      future: backgroundImageApiService.fetchBackgroundImage(
        forceRefresh: bannerRefreshKey > 0,
      ),
      builder: (context, snapshot) {
        final String? imageUrl = snapshot.data;

        return Container(
          height: isDesktop ? 170 : 132,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC9A227).withValues(alpha: 0.26),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageUrl != null)
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildHeroFallbackBackground();
                  },
                )
              else
                _buildHeroFallbackBackground(),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF020617).withValues(alpha: 0.86),
                      const Color(0xFF111827).withValues(alpha: 0.58),
                      const Color(0xFFC9A227).withValues(alpha: 0.72),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      child: const Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isTurkish
                                ? 'Premium teknoloji kataloğu'
                                : 'Premium tech catalog',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isTurkish
                                ? 'Seçili ürünleri keşfet ve sepete ekle.'
                                : 'Explore selected products and add them to your cart.',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroFallbackBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF111827),
            Color(0xFFC9A227),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFC9A227), size: 26),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required String value,
  }) {
    final bool isSelected = selectedCategory == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = value;
          bannerRefreshKey++;
        });
        backgroundImageApiService.clearCachedImage();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFC9A227)
              : widget.isDarkMode
                  ? const Color(0xFF111827)
                  : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isDarkMode ? Colors.white10 : Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : widget.isDarkMode
                    ? Colors.white70
                    : const Color(0xFF111827),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _refreshBanner() {
    backgroundImageApiService.clearCachedImage();
    setState(() {
      bannerRefreshKey++;
    });
  }
}