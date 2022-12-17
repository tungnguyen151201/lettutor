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
        'perPage': '9',
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
}
