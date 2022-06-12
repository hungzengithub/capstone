import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'fade_animation.dart';
import 'forgot_password_success.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController username = new TextEditingController(text: "");
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
                        "Forgot password",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Don't worry, just fill in your username and we'll send you a link to reset your password",
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
                                        style: TextStyle(color: Colors.black87),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        maxLength: 20,
                                        decoration: InputDecoration(
                                            hintText: "Enter your username",
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
                                child: Text('Reset password',
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
                                    String result = await userRepo
                                        .resetPassword(username.text);
                                    if (result != null) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ForgotPasswordSuccess()),
                                          (route) => false);
                                    } else {
                                      setState(() {
                                        username.text = "";
                                      });
                                      Flushbar(
                                        message: APPMESSAGE.RESET_PASS_FAIL,
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
