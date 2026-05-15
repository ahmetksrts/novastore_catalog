

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductApiService {
  // Proje yönergesinde verilen ürün API adresi
  static const String apiUrl = 'https://wantapi.com/products.php';

  // API'den ürünleri çekip Product listesine dönüştürüyorum
  static Future<List<Product>> fetchProducts() async {
    final Uri uri = Uri.parse(apiUrl);
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Ürünler alınamadı');
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is List) {
      return decodedData.map((item) {
        return Product.fromJson(item as Map<String, dynamic>);
      }).toList();
    }

    if (decodedData is Map<String, dynamic>) {
      final dynamic productsData = decodedData['products'] ?? decodedData['data'];

      if (productsData is List) {
        return productsData.map((item) {
          return Product.fromJson(item as Map<String, dynamic>);
        }).toList();
      }
    }

    throw Exception('API veri formatı uygun değil');
  }
}