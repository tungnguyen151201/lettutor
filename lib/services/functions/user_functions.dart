import 'dart:convert';

import 'package:lettutor/services/models/http_response.dart';
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
}
