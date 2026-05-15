class AppTexts {
  static String text(String key, String language) {
    final Map<String, String> tr = {
      'discover': 'Keşfet',
      'products': 'Ürünler',
      'productDetail': 'Ürün Detayı',
      'cart': 'Sepetim',
      'premiumTitle': 'NovaStore Premium',
      'premiumSubtitle': 'Akıllı alışveriş deneyimi',
      'searchHint': 'Ürünlerde ara',
      'heroTitle': 'Premium teknoloji kataloğu',
      'heroSubtitle': 'Seçili ürünleri keşfet ve sepete ekle',
      'productCount': 'Ürün',
      'inCart': 'Sepette',
      'featuredPicks': 'Öne Çıkanlar',
      'seeAll': 'Tümünü gör',
      'allProductsSubtitle': 'Tüm NovaStore ürünlerini incele',
      'description': 'Açıklama',
      'features': 'Özellikler',
      'category': 'Kategori',
      'rating': 'Puan',
      'price': 'Fiyat',
      'addToCart': 'Sepete Ekle',
      'removeFromCart': 'Sepetten Çıkar',
      'checkout': 'Checkout',
      'emptyCartTitle': 'Sepetin boş',
      'emptyCartSubtitle': 'Ürün ekleyerek alışverişe başlayabilirsin',
      'productsCouldNotLoad': 'Ürünler yüklenemedi',
      'checkApiConnection': 'API bağlantısını kontrol edip tekrar deneyebilirsin',
      'tryAgain': 'Tekrar dene',
      'all': 'Tümü',
      'phone': 'Telefon',
      'computer': 'Bilgisayar',
      'tablet': 'Tablet',
      'watch': 'Saat',
      'accessory': 'Aksesuar',
      'technology': 'Teknoloji',
    };

    final Map<String, String> en = {
      'discover': 'Discover',
      'products': 'Products',
      'productDetail': 'Product Detail',
      'cart': 'Cart',
      'premiumTitle': 'NovaStore Premium',
      'premiumSubtitle': 'Smart shopping experience',
      'searchHint': 'Search products',
      'heroTitle': 'Premium tech catalog',
      'heroSubtitle': 'Explore selected products and add them to your cart',
      'productCount': 'Products',
      'inCart': 'In Cart',
      'featuredPicks': 'Featured Picks',
      'seeAll': 'See all',
      'allProductsSubtitle': 'Explore all NovaStore products',
      'description': 'Description',
      'features': 'Features',
      'category': 'Category',
      'rating': 'Rating',
      'price': 'Price',
      'addToCart': 'Add to Cart',
      'removeFromCart': 'Remove from Cart',
      'checkout': 'Checkout',
      'emptyCartTitle': 'Your cart is empty',
      'emptyCartSubtitle': 'Add products to start shopping',
      'productsCouldNotLoad': 'Products could not be loaded',
      'checkApiConnection': 'You can check the API connection and try again',
      'tryAgain': 'Try again',
      'all': 'All',
      'phone': 'Phone',
      'computer': 'Computer',
      'tablet': 'Tablet',
      'watch': 'Watch',
      'accessory': 'Accessory',
      'technology': 'Technology',
    };

    return language == 'TR' ? tr[key] ?? key : en[key] ?? key;
  }

  static String category(String category, String language) {
    final String key = category.trim().toLowerCase();

    final Map<String, String> trCategories = {
      'all': 'Tümü',
      'phone': 'Telefon',
      'computer': 'Bilgisayar',
      'tablet': 'Tablet',
      'watch': 'Saat',
      'accessory': 'Aksesuar',
      'technology': 'Teknoloji',
      'tümü': 'Tümü',
      'telefon': 'Telefon',
      'bilgisayar': 'Bilgisayar',
      'saat': 'Saat',
      'aksesuar': 'Aksesuar',
      'teknoloji': 'Teknoloji',
    };

    final Map<String, String> enCategories = {
      'all': 'All',
      'phone': 'Phone',
      'computer': 'Computer',
      'tablet': 'Tablet',
      'watch': 'Watch',
      'accessory': 'Accessory',
      'technology': 'Technology',
      'tümü': 'All',
      'telefon': 'Phone',
      'bilgisayar': 'Computer',
      'saat': 'Watch',
      'aksesuar': 'Accessory',
      'teknoloji': 'Technology',
    };

    if (language == 'TR') {
      return trCategories[key] ?? category;
    }

    return enCategories[key] ?? category;
  }
}
