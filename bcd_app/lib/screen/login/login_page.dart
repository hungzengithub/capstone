import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/screen/login/change_new_user.dart';
import 'package:bcd_app/screen/tab/home/nativigate_after_login.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forgot_password2.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = new TextEditingController(text: "");
  TextEditingController password = new TextEditingController(text: "");
  String errorUsername = "";
  String errorPassword = "";
  bool _validateUsername = true;
  bool _validatePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
                height: 400,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      width: 85,
                      height: 85,
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/bcd-logo.png"),
                        fit: BoxFit.contain,
                      )),
                    ),
                    Text("Building Crack Detection",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                        )),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 50,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          ILLUSTRATION_BLUE_COLOR_LOGIN,
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.7),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.6),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.4),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.2),
                        ]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: username,
                          style: TextStyle(color: Colors.black),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.visiblePassword,
                          maxLengthEnforced: true,
                          maxLength: 10,
                          onTap: () {
                            setState(() {
                              _validateUsername = true;
                            });
                          },
                          decoration: InputDecoration(
                              counterText: '',
                              hintText: 'Username',
                              errorText: !_validateUsername
                                  ? 'Username is a required field'
                                  : null,
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w300),
                              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 50,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          ILLUSTRATION_BLUE_COLOR_LOGIN,
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.7),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.6),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.4),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.2),
                        ]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          onTap: () {
                            setState(() {
                              _validatePassword = true;
                            });
                          },
                          decoration: InputDecoration(
                              errorText: !_validatePassword
                                  ? 'Password is a required field'
                                  : null,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w300),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 10),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ForgotPassword2()));
                      },
                      child: Text("Forgot your password?",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          ILLUSTRATION_BLUE_COLOR_LOGIN,
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.7),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.6),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.4),
                          ILLUSTRATION_BLUE_COLOR_LOGIN.withOpacity(0.2),
                        ]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: ILLUSTRATION_BLUE_COLOR_2,
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            username.text.isEmpty
                                ? _validateUsername = false
                                : _validateUsername = true;
                            password.text.isEmpty
                                ? _validatePassword = false
                                : _validatePassword = true;
                          });
                          if (!_validateUsername || !_validatePassword) {
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xfff8f8f8),
                                    title: Container(
                                      height: 150,
                                      color: Color(0xfff8f8f8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Login processing",
                                              style: TextStyle(fontSize: 22)),
                                          SizedBox(height: 10),
                                          Text("Please wait for a few minutes",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 16)),
                                          Container(
                                            width: double.infinity,
                                            child: Container(
                                              height: 80,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/droneloading.gif"),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                            UserRepository userRepo = new UserRepository();
                            await userRepo
                                .login(username.text, password.text)
                                .then((dto) {
                              Navigator.of(context).pop();
                              if (dto != null) {
                                if (dto.isNewUser) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (c) => ChangeNewUserPass()),
                                      (route) => false);
                                } else {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (c) => NativigateAfterLogin(
                                                username: username.text,
                                                password: password.text,
                                              )),
                                      (route) => false);
                                }
                              } else {
                                setState(() {
                                  username.text = "";
                                  password.text = "";
                                });
                                Flushbar(
                                  message: APPMESSAGE.LOGIN_FAIL,
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/loginbackground.jpg"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
