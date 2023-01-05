import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/screens/tutor/home.dart';
import 'package:lettutor/services/functions/auth_functions.dart';
import 'package:lettutor/services/models/user.dart';
import 'package:lettutor/utils/validate_email.dart';

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
  late GoogleSignIn googleSignIn;

  void handleSignInGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;

      if (accessToken != null) {
        final response = await AuthFunctions.loginWithGoogle(accessToken);
        if (response['isSuccess'] == false) {
          setState(() {
            isSuccess = response['isSuccess'] as bool;
            message = response['message'] as String;
          });
        } else {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      setState(() {
        isSuccess = false;
        message = e.toString();
      });
    }
  }

  void handleSingInFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final String accessToken = result.accessToken!.token;
        final response = await AuthFunctions.loginWithFacebook(accessToken);
        if (response['isSuccess'] == false) {
          setState(() {
            isSuccess = response['isSuccess'] as bool;
            message = response['message'] as String;
          });
        } else {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        setState(() {
          isSuccess = false;
          message = result.message!;
        });
      }
    } catch (e) {
      setState(() {
        isSuccess = false;
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();
    googleSignIn = GoogleSignIn();

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
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              obscureText: true,
              controller: repasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhập lại mật khẩu',
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
                    passwordController.text == '' ||
                    repasswordController.text == '') {
                  setState(() {
                    isSuccess = false;
                    message = 'Vui lòng điền đầy đủ thông tin';
                  });
                } else if (!validateEmail(nameController.text)) {
                  setState(() {
                    isSuccess = false;
                    message = 'Email không hợp lệ';
                  });
                } else if (passwordController.text.length < 6) {
                  setState(() {
                    isSuccess = false;
                    message = 'Mật khẩu phải có độ dài ít nhất 6 ký tự';
                  });
                } else if (repasswordController.text !=
                    passwordController.text) {
                  setState(() {
                    isSuccess = false;
                    message = 'Mật khẩu không trùng khớp';
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
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      handleSingInFacebook();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xff007CFF))),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(5)),
                    child: SvgPicture.asset("asset/svg/ic_facebook.svg",
                        width: 30, height: 30, color: const Color(0xff007CFF))),
                ElevatedButton(
                    onPressed: () {
                      handleSignInGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xff007CFF))),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(5)),
                    child: SvgPicture.asset("asset/svg/ic_google.svg",
                        width: 30, height: 30)),
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
