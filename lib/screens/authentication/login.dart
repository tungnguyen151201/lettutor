import 'package:flutter/material.dart';
import 'package:lettutor/screens/authentication/forgot_password.dart';
import 'package:lettutor/screens/authentication/register.dart';
import 'package:lettutor/screens/tutor/home.dart';
import 'package:lettutor/services/functions/auth_functions.dart';
import 'package:lettutor/services/models/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LetTutor")),
      body: const LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  late String message = '';
  @override
  bool get mounted => super.mounted;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mật khẩu',
              ),
            ),
          ),
          message != ''
              ? Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : Container(),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen()),
              );
            },
            child: const Text(
              'Quên mật khẩu?',
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('ĐĂNG NHẬP'),
              onPressed: () async {
                if (nameController.text == '' ||
                    passwordController.text == '') {
                  setState(() {
                    message = 'Vui lòng điền đầy đủ thông tin';
                  });
                } else {
                  var response = await AuthFunctions.login(
                      User(nameController.text, passwordController.text));
                  if (response['isSuccess'] == false) {
                    setState(() {
                      message = response['message'].toString();
                    });
                  } else {
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            alignment: Alignment.center,
            child: const Text('Hoặc tiếp tục với'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Icon(
                  Icons.facebook,
                  size: 30,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.email,
                  size: 30,
                  color: Colors.lightBlueAccent,
                ),
                Icon(
                  Icons.phone_android,
                  size: 30,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Chưa có tài khoản?'),
              TextButton(
                child: const Text(
                  'Đăng ký',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
