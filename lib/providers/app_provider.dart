import 'package:flutter/cupertino.dart';
import 'package:lettutor/services/models/language.dart';
import 'package:lettutor/services/models/language_en.dart';
import 'package:lettutor/services/models/language_vi.dart';

class AppProvider extends ChangeNotifier {
  Language _language = VietNamese();

  set language(Language lang) {
    _language = lang;
    notifyListeners();
  }

  Language get language => _language;
}
