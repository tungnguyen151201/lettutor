import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  // final en = English();
  // final vi = VietNamese();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Cài đặt'),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: PopupMenuButton(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ngôn ngữ',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      // appProvider.language.name == 'EN' ? 'English' : 'Tiếng Việt',
                      'Tiếng Việt',
                      style: TextStyle(fontSize: 14),
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
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: PopupMenuButton(
                elevation: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Chủ đề',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      // appProvider.language.name == 'EN' ? 'English' : 'Tiếng Việt',
                      'Sáng',
                      style: TextStyle(fontSize: 14),
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
                        const Text('Sáng'),
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
                        const Text('Tối'),
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
