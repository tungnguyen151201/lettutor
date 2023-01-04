import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lettutor/services/models/http_response.dart';
import 'package:lettutor/services/models/learning_topic.dart';
import 'package:lettutor/services/models/test_preparation.dart';
import 'package:lettutor/services/models/user_info.dart';
import 'package:lettutor/services/settings/host.dart';
import 'package:http/http.dart' as http;

class UserFunctions {
  static Future<Map<String, Object>> forgotPassword(String email) async {
    try {
      var url = Uri.https(apiUrl, 'user/forgotPassword');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
          }));

      if (response.statusCode == 200) {
        return {
          'isSuccess': true,
          'message':
              'Email sent successfully, check your email to reset your password'
        };
      } else {
        return {
          'isSuccess': true,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<UserInfo?> getUserInformation() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'user/info');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final user = UserInfo.fromJson(json.decode(response.body)['user']);
      return user;
    } else {
      return null;
    }
  }

  static Future<List<LearnTopic>?> getAllLearningTopic() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'learn-topic');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTopics = jsonRes.map((e) => LearnTopic.fromJson(e)).toList();
      return allTopics;
    } else {
      return null;
    }
  }

  static Future<List<TestPreparation>?> getAllTestPreparation() async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'test-preparation');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTestPreparation =
          jsonRes.map((e) => TestPreparation.fromJson(e)).toList();
      return allTestPreparation;
    } else {
      return null;
    }
  }

  static Future<UserInfo?> updateUserInformation(
      String name,
      String country,
      String birthday,
      String level,
      String studySchedule,
      List<String>? learnTopics,
      List<String>? testPreparations) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.https(apiUrl, 'user/info');
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'name': name,
          'country': country,
          'birthday': birthday,
          'level': level,
          'studySchedule': studySchedule,
          'learnTopics': learnTopics,
          'testPreparations': testPreparations,
        }));

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final user = UserInfo.fromJson(jsonRes['user']);
      return user;
    } else {
      return null;
    }
  }

  static Future<bool> uploadAvatar(String path) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');

    final request = http.MultipartRequest(
        'POST', Uri.parse('https://$apiUrl/user/uploadAvatar'));

    final img = await http.MultipartFile.fromPath('avatar', path);

    request.files.add(img);
    request.headers.addAll({'Authorization': 'Bearer $token'});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
