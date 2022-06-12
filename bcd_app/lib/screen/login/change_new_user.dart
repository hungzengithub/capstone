import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'fade_animation.dart';
import 'login_page.dart';

class ChangeNewUserPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ChangeNewUserPassState();
}

class _ChangeNewUserPassState extends State<ChangeNewUserPass> {
  TextEditingController oldPassword = new TextEditingController(text: "");
  TextEditingController newPassword = new TextEditingController(text: "");

  String errorOldPass = "";
  String errorNewPass = "";

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
                        child: Text("Update password",
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
                            "This is the first time you enter here. Change your password to continue",
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
                          controller: oldPassword,
                          onChanged: (text) {
                            setState(() {
                              if (text.length > 20) {
                                errorOldPass =
                                    "Password must less than 20 characters";
                              } else
                                errorOldPass = "";
                            });
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          style: TextStyle(color: Colors.grey[500]),
                          decoration: InputDecoration(
                              hintText: 'Old password',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w300),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 0, 10, 10),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
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
                          controller: newPassword,
                          onChanged: (text) {
                            setState(() {
                              if (text.length > 20) {
                                errorNewPass =
                                    "Password must less than 20 characters";
                              } else
                                errorNewPass = "";
                            });
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.grey[500]),
                          decoration: InputDecoration(
                              hintText: 'New Password',
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
                          'Change password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (oldPassword.text == '') {
                          } else {
                            UserRepository userRepo = new UserRepository();
                            userRepo
                                .changeNewUserPasss(
                                    oldPassword.text, newPassword.text)
                                .then((result) {
                              if (result) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text(APPMESSAGE.RESET_PASS_SUCCESS),
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
                                                      BorderRadius.circular(
                                                          5.0),
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
                                                              color:
                                                                  Colors.white,
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
                                  oldPassword.text = "";
                                  newPassword.text = "";
                                });
                                Flushbar(
                                  message: "Your password is incorrect!!",
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
