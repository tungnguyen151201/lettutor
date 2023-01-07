import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/services/models/language_en.dart';
import 'package:lettutor/services/models/language_vi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final en = English();
  final vi = VietNamese();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(lang.setting),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: PopupMenuButton(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.languages,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      appProvider.language.name == 'EN'
                          ? 'English'
                          : 'Tiếng Việt',
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 20,
                          child: Image.asset('asset/img/flag_vietnam.png'),
                        ),
                        const Text('Tiếng Việt'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 20,
                          child: SvgPicture.asset(
                            'asset/svg/ic_flag_kingdom.svg',
                            width: 20,
                          ),
                        ),
                        const Text('English'),
                      ],
                    ),
                  ),
                ],
                onSelected: (int value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (value == 0) {
                    appProvider.language = vi;
                    await prefs.setString("lang", "VI");
                  } else {
                    appProvider.language = en;
                    await prefs.setString("lang", "EN");
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: PopupMenuButton(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.theme,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      // appProvider.language.name == 'EN' ? 'English' : 'Tiếng Việt',
                      lang.light,
                      style: const TextStyle(fontSize: 14),
                    )
                  ],
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 20,
                          child: const Icon(Icons.light_mode),
                        ),
                        Text(lang.light),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: const Icon(Icons.dark_mode)),
                        Text(lang.dark),
                      ],
                    ),
                  ),
                ],
                onSelected: (int value) async {
                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                  // if (value == 0) {
                  //   appProvider.language = vi;
                  //   await prefs.setString('lang', 'VI');
                  // } else {
                  //   appProvider.language = en;
                  //   await prefs.setString('lang', 'EN');
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
