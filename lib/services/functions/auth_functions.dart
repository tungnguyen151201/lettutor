import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lettutor/services/models/http_response.dart';
import 'package:lettutor/services/models/login_response.dart';
import 'package:lettutor/services/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/services/settings/host.dart';

class AuthFunctions {
  static Future<Map<String, Object>> register(User user) async {
    try {
      var url = Uri.https(apiUrl, 'auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
            'source': null
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'isSuccess': true,
          'message':
              'Register successfully, check your email to activate your account'
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> login(User user) async {
    try {
      var url = Uri.https(apiUrl, 'auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
          }));

      if (response.statusCode == 200) {
        var storage = const FlutterSecureStorage();
        String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        await storage.write(key: 'accessToken', value: token);
        return {
          'isSuccess': true,
          'token': token,
        };
      } else {
        return {
          'isSuccess': false,
          'message': HttpResponse.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

  static Future<Map<String, Object>> loginWithGoogle(String accessToken) async {
    var url = Uri.https(apiUrl, 'auth/google');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
      await storage.write(key: 'accessToken', value: token);
      return {
        'isSuccess': true,
        'token': token,
      };
    } else {
      return {
        'isSuccess': false,
        'message': HttpResponse.fromJson(jsonDecode(response.body)).message
      };
    }
  }

  static Future<Map<String, Object>> loginWithFacebook(
      String accessToken) async {
    var url = Uri.https(apiUrl, 'auth/facebook');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'access_token': accessToken}));

    if (response.statusCode == 200) {
      var storage = const FlutterSecureStorage();
      String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
      await storage.write(key: 'accessToken', value: token);
      return {
        'isSuccess': true,
        'token': token,
      };
    } else {
      return {
        'isSuccess': false,
        'message': HttpResponse.fromJson(jsonDecode(response.body)).message
      };
    }
  }
}
