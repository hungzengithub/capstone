import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/screen/dialog/noti_dialog.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final UserDTO dto;

  const ChangePassword({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPass = new TextEditingController(text: "");
  TextEditingController newPass = new TextEditingController(text: "");
  TextEditingController confirm = new TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: ILLUSTRATION_BLUE_COLOR),
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
                        "Change Password",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Change your password here!",
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
                  child: Form(
                    key: _formKey,
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
                                          color: ILLUSTRATION_BLUE_COLOR
                                              .withOpacity(0.3),
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
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            }
                                            RegExp regex =
                                                new RegExp(PASSWORD_PATTERN);
                                            if (!regex.hasMatch(text))
                                              return 'Must contain at least one uppercase and one number';
                                            return null;
                                          },
                                          maxLength: 20,
                                          controller: oldPass,
                                          style:
                                              TextStyle(color: Colors.black87),
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: "Old password",
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
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            }
                                            RegExp regex =
                                                new RegExp(PASSWORD_PATTERN);
                                            if (!regex.hasMatch(text))
                                              return 'Must contain at least one uppercase and one number';
                                            return null;
                                          },
                                          maxLength: 20,
                                          controller: newPass,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          style:
                                              TextStyle(color: Colors.black87),
                                          decoration: InputDecoration(
                                              hintText: "New password",
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
                                        child: TextFormField(
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Text is empty';
                                            } else if (text != newPass.text) {
                                              return 'Confirm password is not matched';
                                            }

                                            return null;
                                          },
                                          controller: confirm,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          maxLength: 20,
                                          obscureText: true,
                                          style:
                                              TextStyle(color: Colors.black87),
                                          decoration: InputDecoration(
                                              hintText: "Confirm password",
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
                                  color: ILLUSTRATION_BLUE_COLOR,
                                ),
                                child: RaisedButton(
                                  child: Text('Change password',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  color: ILLUSTRATION_BLUE_COLOR,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      UserRepository userRepo =
                                          new UserRepository();
                                      String result =
                                          await userRepo.changePassword(
                                              oldPass.text, newPass.text);
                                      if (result == null) {
                                        showDialog(
                                            context: this.context,
                                            builder: (_) => NotiDiaglog(
                                                "Error",
                                                "Your old password maybe incorrect",
                                                Colors.red,
                                                widget.dto));
                                      } else if (result.contains(
                                          "Change password success")) {
                                        showDialog(
                                            context: this.context,
                                            builder: (_) => NotiDiaglog(
                                                "Notification",
                                                APPMESSAGE
                                                    .CHANGE_PASSWORD_SUCCESS,
                                                Colors.green,
                                                widget.dto));
                                      } else {
                                        showDialog(
                                            context: this.context,
                                            builder: (_) => NotiDiaglog(
                                                "Error",
                                                APPMESSAGE.CHANGE_PASSWORD_FAIL,
                                                Colors.red,
                                                widget.dto));
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
