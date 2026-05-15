import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screens/home_screen.dart';
import 'services/product_api_service.dart';

void main() {
  runApp(const NovaStoreApp());
}

class NovaStoreApp extends StatefulWidget {
  const NovaStoreApp({super.key});

  @override
  State<NovaStoreApp> createState() => _NovaStoreAppState();
}

class _NovaStoreAppState extends State<NovaStoreApp> {
  final List<Product> cartItems = [];

  late Future<List<Product>> productFuture;

  bool isDarkMode = false;
  String selectedLanguage = 'TR';

  @override
  void initState() {
    super.initState();
    productFuture = ProductApiService.fetchProducts();
  }

  void addToCart(Product product) {
    setState(() {
      if (!cartItems.contains(product)) {
        cartItems.add(product);
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  void changeTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  void changeLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  void reloadProducts() {
    setState(() {
      // hata ekranındaki tekrar dene butonu burayı çalıştırıyor
      productFuture = ProductApiService.fetchProducts();
    });
  }

  // açık tema renkleri
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFC9A227),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFFC9A227),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF111827),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // koyu tema renkleri
  ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFC9A227),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0B0F19),
      cardColor: const Color(0xFF111827),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Color(0xFF0B0F19),
        foregroundColor: Color(0xFFC9A227),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC9A227),
          foregroundColor: const Color(0xFF0B0F19),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaStore Catalog',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: FutureBuilder<List<Product>>(
        future: productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _LoadingScreen(isDarkMode: isDarkMode);
          }

          if (snapshot.hasError) {
            return _ErrorScreen(
              isDarkMode: isDarkMode,
              selectedLanguage: selectedLanguage,
              onRetry: reloadProducts,
            );
          }

          final List<Product> products = snapshot.data ?? [];

          return HomeScreen(
            products: products,
            cartItems: cartItems,
            onAddToCart: addToCart,
            onRemoveFromCart: removeFromCart,
            isDarkMode: isDarkMode,
            onThemeChanged: changeTheme,
            selectedLanguage: selectedLanguage,
            onLanguageChanged: changeLanguage,
          );
        },
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  final bool isDarkMode;

  const _LoadingScreen({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF0B0F19) : const Color(0xFFF8FAFC),
      body: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFC9A227),
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final bool isDarkMode;
  final String selectedLanguage;
  final VoidCallback onRetry;

  const _ErrorScreen({
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.onRetry,
  });

  bool get isTurkish => selectedLanguage == 'TR';

  String get titleText =>
      isTurkish ? 'Ürünler yüklenemedi' : 'Products could not load';

  String get descriptionText => isTurkish
      ? 'API bağlantısını kontrol edip tekrar deneyebilirsin'
      : 'Please check the API connection and try again';

  String get buttonText => isTurkish ? 'Tekrar dene' : 'Try again';

  @override
  Widget build(BuildContext context) {
    final Color textColor = isDarkMode ? Colors.white : const Color(0xFF111827);
    final Color mutedTextColor = isDarkMode ? Colors.white60 : Colors.grey;

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xFF0B0F19) : const Color(0xFFF8FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 72,
                color: Color(0xFFC9A227),
              ),
              const SizedBox(height: 18),
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                descriptionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mutedTextColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}