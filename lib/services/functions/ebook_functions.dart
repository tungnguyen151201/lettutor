import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/services/models/ebook.dart';
import 'package:lettutor/services/settings/host.dart';

class EbookFunctions {
  static Future<List<Ebook>?> getListEbookWithPagination(
    int page,
    int size, {
    String q = '',
    String categoryId = '',
  }) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    final queryParameters = {
      'page': '$page',
      'size': '$size',
    };

    if (q.isNotEmpty) {
      queryParameters.addAll({'q': q});
    }

    if (categoryId.isNotEmpty) {
      queryParameters.addAll({'categoryId[]': categoryId});
    }

    var url = Uri.https(apiUrl, 'e-book', queryParameters);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final ebooks = res['data']['rows'] as List;
      final arr = ebooks.map((e) => Ebook.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }
}
