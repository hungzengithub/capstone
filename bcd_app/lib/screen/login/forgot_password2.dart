import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fade_animation.dart';
import 'login_page.dart';

class ForgotPassword2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword2> {
  TextEditingController username = new TextEditingController(text: "");
  String errorUsername = "";
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 80),
                    FadeAnimation(
                      1.3,
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text("Forgot password",
                            style: TextStyle(
                              color: ILLUSTRATION_ORANGE_COLOR_FORGOTPASS,
                              fontSize: 30,
                            )),
                      ),
                    ),
                    FadeAnimation(
                        1.3,
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Don't worry, just fill in your username and we'll send you a link to reset your password",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        )),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 40,
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(begin: Alignment.topCenter, colors: [
                          ILLUSTRATION_ORANGE_COLOR_FORGOTPASS.withOpacity(0.4),
                          ILLUSTRATION_ORANGE_COLOR_FORGOTPASS.withOpacity(0.3),
                          ILLUSTRATION_ORANGE_COLOR_FORGOTPASS.withOpacity(0.3),
                          ILLUSTRATION_ORANGE_COLOR_FORGOTPASS.withOpacity(0.2),
                          ILLUSTRATION_ORANGE_COLOR_FORGOTPASS.withOpacity(0.1),
                        ]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: username,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.visiblePassword,
                          maxLengthEnforced: true,
                          style: TextStyle(color: Colors.grey[500]),
                          decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w300),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 10),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: ILLUSTRATION_GREY_HIGH_COLOR,
                        child: Text(
                          'Reset password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (username.text == '') {
                          } else {
                            UserRepository userRepo = new UserRepository();
                            String result =
                                await userRepo.resetPassword(username.text);
                            if (result != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(APPMESSAGE.RESET_PASS_SUCCESS),
                                    content: Container(
                                        height: 130,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Reset password URL has been sent to the email successfully!",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14),
                                            ),
                                            SizedBox(height: 20),
                                            FlatButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                LoginScreen()),
                                                        (route) => false);
                                              },
                                              child: Container(
                                                  width: double.infinity,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Login now",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14.0),
                                                      ),
                                                      Icon(
                                                          Icons
                                                              .arrow_forward_outlined,
                                                          color: Colors.white)
                                                    ],
                                                  )),
                                              color:
                                                  ILLUSTRATION_GREY_HIGH_COLOR,
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              );
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("<< Back to login",
                            style: TextStyle(
                                color: ILLUSTRATION_GREY_HIGH_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/1.jpg"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
