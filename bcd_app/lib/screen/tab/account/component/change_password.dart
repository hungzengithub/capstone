import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/user_repository.dart';
import 'package:bcd_app/screen/dialog/noti_dialog.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword2 extends StatefulWidget {
  final String status;
  final UserDTO dto;
  ChangePassword2({@required this.status, @required this.dto});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ChangePassword2> {
  TextEditingController oldPass = new TextEditingController(text: "");
  TextEditingController newPass = new TextEditingController(text: "");
  TextEditingController confirm = new TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: DEFAULT_COLOR_3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )),
                        ],
                      )),
                  Container(
                    height: 150,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 10, left: 30),
                              child: Text(
                                "Old Password",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.w700),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            // height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Text is empty';
                                }
                                RegExp regex = new RegExp(PASSWORD_PATTERN);
                                if (!regex.hasMatch(text))
                                  return 'Must contain at least one uppercase and one number';
                                return null;
                              },
                              controller: oldPass,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                  )),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 30, top: 30),
                              child: Text(
                                "New Password",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.w700),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Text is empty';
                                }
                                RegExp regex = new RegExp(PASSWORD_PATTERN);
                                if (!regex.hasMatch(text))
                                  return 'Must contain at least one uppercase and one number';
                                return null;
                              },
                              controller: newPass,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                  )),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 30, top: 30),
                              child: Text(
                                "Confirm Password",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: DEFAULT_COLOR,
                                    fontWeight: FontWeight.w700),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 20),
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
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.0),
                                  )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            margin: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 30),
                            child: FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  UserRepository userRepo =
                                      new UserRepository();
                                  String result = await userRepo.changePassword(
                                      oldPass.text, newPass.text);
                                  if (result == null) {
                                    showDialog(
                                        context: this.context,
                                        builder: (_) => NotiDiaglog(
                                            "Error",
                                            "Your old password maybe incorrect",
                                            Colors.red,
                                            widget.dto));
                                  } else if (result
                                      .contains("Change password success")) {
                                    showDialog(
                                        context: this.context,
                                        builder: (_) => NotiDiaglog(
                                            "Notification",
                                            "You successfully changed your password",
                                            Colors.green,
                                            widget.dto));
                                  } else {
                                    showDialog(
                                        context: this.context,
                                        builder: (_) => NotiDiaglog(
                                            "Error",
                                            "Your old password maybe incorrect",
                                            Colors.red,
                                            widget.dto));
                                  }
                                }
                              },
                              child: Text(
                                "Change Password",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
