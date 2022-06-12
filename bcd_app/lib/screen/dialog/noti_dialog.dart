import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/account/account_screen.dart';
import 'package:flutter/material.dart';

class NotiDiaglog extends StatelessWidget {
  final String title;
  final String message;
  final Color color;
  final UserDTO dto;
  NotiDiaglog(this.title, this.message, this.color, this.dto);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: color,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              message,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            )),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: FlatButton(
                                      color: Colors.blueGrey,
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(8.0),
                                      splashColor: Colors.blueAccent,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Close",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
