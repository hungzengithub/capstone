import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';

import 'package:flutter/material.dart';

import 'fade_animation.dart';
import 'login_page.dart';

class ForgotPasswordSuccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordSuccess> {
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
                        APPMESSAGE.RESET_PASS_SUCCESS,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Reset password URL has been sent to the email successfully!",
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
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Login now',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)),
                                      Icon(Icons.arrow_forward_sharp,
                                          color: Colors.white)
                                    ]),
                                color: DEFAULT_COLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (c) => LoginScreen()),
                                      (route) => false);
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
