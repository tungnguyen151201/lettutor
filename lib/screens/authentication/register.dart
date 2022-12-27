import 'package:flutter/material.dart';
import 'package:lettutor/services/functions/auth_functions.dart';
import 'package:lettutor/services/models/user.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LetTutor")),
      body: const RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late String message = '';
  late bool isSuccess = false;

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
                'Đăng ký',
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
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style:
                        TextStyle(color: isSuccess ? Colors.green : Colors.red),
                  ),
                )
              : Container(),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('ĐĂNG KÝ'),
              onPressed: () async {
                if (nameController.text == '' ||
                    passwordController.text == '') {
                  setState(() {
                    isSuccess = false;
                    message = 'Vui lòng điền đầy đủ thông tin';
                  });
                } else {
                  var response = await AuthFunctions.register(
                      User(nameController.text, passwordController.text));
                  setState(() {
                    isSuccess = response['isSuccess'] as bool;
                    message = response['message'] as String;
                  });
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
              const Text('Đã có tài khoản?'),
              TextButton(
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
