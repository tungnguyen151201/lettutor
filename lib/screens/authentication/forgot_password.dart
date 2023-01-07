import 'package:flutter/material.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/services/functions/user_functions.dart';
import 'package:provider/provider.dart';

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
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(lang.resetPassword)),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    lang.resetPassword,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    lang.emptyEmail,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: lang.email,
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
                    child: Text(lang.confirm),
                    onPressed: () async {
                      if (nameController.text == '') {
                        setState(() {
                          isSuccess = false;
                          message = lang.emptyEmail;
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
