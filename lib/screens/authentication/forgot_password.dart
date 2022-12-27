import 'package:flutter/material.dart';
import 'package:lettutor/services/functions/auth_functions.dart';
import 'package:lettutor/services/functions/user_functions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late String message = '';
  late bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Quên mật khẩu")),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Đặt lại mật khẩu',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Vui lòng nhập email để tìm kiếm tài khoản của bạn.',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
              message != ''
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        message,
                        style: TextStyle(
                            color: isSuccess ? Colors.green : Colors.red),
                      ),
                    )
                  : Container(),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Xác nhận'),
                    onPressed: () async {
                      if (nameController.text == '') {
                        setState(() {
                          isSuccess = false;
                          message = 'Vui lòng điền email';
                        });
                      } else {
                        var response = await UserFunctions.forgotPassword(
                            nameController.text);
                        setState(() {
                          isSuccess = response['isSuccess'] as bool;
                          message = response['message'] as String;
                        });
                      }
                    },
                  )),
            ],
          )),
    );
  }
}
