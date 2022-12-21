import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lettutor/services/models/tutor.dart';
import 'package:lettutor/services/settings/host.dart';
import 'package:http/http.dart' as http;

class TutorFunctions {
  static Future<List<Tutor>?> getTutorList() async {
    List<Tutor> tutorList = <Tutor>[];
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    try {
      final queryParameters = {
        'perPage': '55',
        'page': '1',
      };
      var url = Uri.https(apiUrl, 'tutor/more', queryParameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        var tutorArray = jsonDecode(response.body)['tutors']['rows'];
        for (var tutor in tutorArray) {
          tutorList.add(Tutor.fromJson(tutor));
        }
        return tutorList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<Tutor?> getTutorInfomation(String id) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    try {
      var url = Uri.https(apiUrl, 'tutor/$id');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return Tutor.fromJson2(jsonDecode(response.body));
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<bool> manageFavoriteTutor(String id) async {
    var storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'accessToken');
    try {
      var url = Uri.https(apiUrl, 'user/manageFavoriteTutor');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode({
            'tutorId': id,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
    }
  }
}
