import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/services/models/course.dart';
import 'package:lettutor/services/models/course_category.dart';
import 'package:lettutor/services/settings/host.dart';

class CourseFunctions {
  static Future<List<Course>?> getListCourseWithPagination(
    int page,
    int size, {
    String q = "",
    String categoryId = "",
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

    var url = Uri.https(apiUrl, 'course', queryParameters);
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['data']['rows'] as List;
      final arr = courses.map((e) => Course.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static Future<List<CourseCategory>?> getAllCourseCategories() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'content-category');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final courses = res['rows'] as List;
      final arr = courses.map((e) => CourseCategory.fromJson(e)).toList();
      return arr;
    } else {
      return null;
    }
  }

  static getCourseById(String courseId) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'course/$courseId');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final course = Course.fromJson(res['data']);
      return course;
    } else {
      return null;
    }
  }
}
