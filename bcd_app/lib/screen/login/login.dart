import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/screen/tab/home/nativigate_after_login.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'fade_animation.dart';
import 'forgot_password.dart';

class LoginScreenTrash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenTrash> {
  TextEditingController username = new TextEditingController(text: "");
  TextEditingController password = new TextEditingController(text: "");
  String errorUsername = "";
  String errorPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.teal[300],
          Colors.teal[200],
          Colors.teal[100]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome to BCD System",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: DEFAULT_COLOR_2,
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: username,
                                        maxLength: 15,
                                        style: TextStyle(color: Colors.black87),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        onChanged: (text) {
                                          setState(() {
                                            if (text.length > 20) {
                                              errorUsername =
                                                  "Username must less than 15 characters";
                                            } else
                                              errorUsername = "";
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Enter username",
                                            errorText: errorUsername,
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextField(
                                        controller: password,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        maxLength: 20,
                                        obscureText: true,
                                        style: TextStyle(color: Colors.black87),
                                        decoration: InputDecoration(
                                            hintText: "Enter password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      )),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ForgotPassword()));
                            },
                            child: Container(
                              child: FadeAnimation(
                                  1.5,
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: DEFAULT_COLOR_2,
                              ),
                              child: RaisedButton(
                                child: Text('Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                color: DEFAULT_COLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () async {
                                  if (username.text == '') {
                                  } else {
                                    UserRepository userRepo =
                                        new UserRepository();
                                    UserDTO dto = await userRepo.login(
                                        username.text, password.text);
                                    if (dto != null) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  NativigateAfterLogin(
                                                    username: username.text,
                                                    password: password.text,
                                                  )),
                                          (route) => false);
                                    } else {
                                      setState(() {
                                        username.text = "";
                                        password.text = "";
                                      });
                                      Flushbar(
                                        message:
                                            "Your username or password is incorrect!!",
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    }
                                  }
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
