import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class BackgroundImageApiService {
  static const String _baseUrl = 'https://picsum.photos/v2/list';

  String? _cachedImageUrl;

  Future<String?> fetchBackgroundImage({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedImageUrl != null) {
      return _cachedImageUrl;
    }

    try {
      final int page = Random().nextInt(8) + 1;

      final Uri url = Uri.parse(_baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'limit': '20',
        },
      );

      final http.Response response = await http.get(url);

      if (response.statusCode != 200) {
        return null;
      }

      final dynamic decodedData = jsonDecode(response.body);

      if (decodedData is! List || decodedData.isEmpty) {
        return null;
      }

      final List<dynamic> landscapePhotos = decodedData.where((photo) {
        if (photo is! Map<String, dynamic>) {
          return false;
        }

        final int width = int.tryParse(photo['width'].toString()) ?? 0;
        final int height = int.tryParse(photo['height'].toString()) ?? 0;

        return width > height;
      }).toList();

      final List<dynamic> photoList =
          landscapePhotos.isNotEmpty ? landscapePhotos : decodedData;

      final dynamic selectedPhoto = photoList[Random().nextInt(photoList.length)];

      if (selectedPhoto is Map<String, dynamic>) {
        final String id = selectedPhoto['id'].toString();
        _cachedImageUrl = 'https://picsum.photos/id/$id/1200/500';
        return _cachedImageUrl;
      }

      return null;
    } catch (_) {
      return null;
    }
  }
  void clearCachedImage() {
    _cachedImageUrl = null;
  }
}