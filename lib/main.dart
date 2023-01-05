import 'package:flutter/material.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:provider/provider.dart';

import 'screens/authentication/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AppProvider(),
      ),
    ], child: const MaterialApp(home: LoginScreen()));
  }
}
