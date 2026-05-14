import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/home_screen.dart';

void main() {
  // Uygulamanın başlangıç noktası
  runApp(const NovaStoreApp());
}

class NovaStoreApp extends StatefulWidget {
  const NovaStoreApp({super.key});

  @override
  State<NovaStoreApp> createState() => _NovaStoreAppState();
}

class _NovaStoreAppState extends State<NovaStoreApp> {
  // Sepete eklenen ürünleri bu listede tutuyorum
  final List<Product> cartItems = [];

  // Tema ve dil seçimi ana uygulama seviyesinde tutuyorum
  bool isDarkMode = false;
  String selectedLanguage = 'TR';

  void addToCart(Product product) {
    setState(() {
      // Aynı ürünün sepete ikinci kez eklenmesini engelliyorum
      if (!cartItems.contains(product)) {
        cartItems.add(product);
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      // Ürün sepetten çıkarıldığında ekrandaki sayaç da güncelleniyor
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

  // Gündüz modu için kullandığım tema ayarları
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

  // Gece modu için kullandığım tema ayarları
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
      // Kullanıcının seçimine göre tema değiştiriliyor
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(
        cartItems: cartItems,
        onAddToCart: addToCart,
        onRemoveFromCart: removeFromCart,
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
        selectedLanguage: selectedLanguage,
        onLanguageChanged: changeLanguage,
      ),
    );
  }
}