import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/providers/app_provider.dart';
import 'package:lettutor/screens/authentication/forgot_password.dart';
import 'package:lettutor/screens/authentication/register.dart';
import 'package:lettutor/screens/tutor/home.dart';
import 'package:lettutor/services/functions/auth_functions.dart';
import 'package:lettutor/services/models/language_en.dart';
import 'package:lettutor/services/models/language_vi.dart';
import 'package:lettutor/services/models/user.dart';
import 'package:lettutor/utils/validate_email.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late bool isSuccess = false;
  late GoogleSignIn googleSignIn;

  @override
  bool get mounted => super.mounted;
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

  bool isLanguageLoading = true;

  void loadLanguage(AppProvider appProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang') ?? "VN";
    if (lang == "EN") {
      appProvider.language = English();
    } else {
      appProvider.language = VietNamese();
    }
    isLanguageLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;
    if (isLanguageLoading) {
      loadLanguage(appProvider);
    }

    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    googleSignIn = GoogleSignIn();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                lang.signIn,
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
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
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: lang.password,
              ),
            ),
          ),
          message != ''
              ? Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message,
                    style:
                        TextStyle(color: isSuccess ? Colors.green : Colors.red),
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
            child: Text(
              lang.forgotPassword,
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text(lang.signIn),
              onPressed: () async {
                if (nameController.text == '' ||
                    passwordController.text == '') {
                  setState(() {
                    isSuccess = false;
                    message = lang.emptyField;
                  });
                } else if (!validateEmail(nameController.text)) {
                  setState(() {
                    isSuccess = false;
                    message = lang.invalidEmail;
                  });
                } else {
                  var response = await AuthFunctions.login(
                      User(nameController.text, passwordController.text));
                  if (response['isSuccess'] == false) {
                    setState(() {
                      isSuccess = response['isSuccess'] as bool;
                      message = response['message'] as String;
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
            child: Text(lang.continueWith),
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
              Text(lang.signUpQuestion),
              TextButton(
                child: Text(
                  lang.signUp,
                  style: const TextStyle(fontSize: 18),
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
