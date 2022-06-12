import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

import '../crack_screen.dart';

// ignore: must_be_immutable
class DeniedNotVerify extends StatelessWidget {
  final UserDTO dto;
  final CrackDTO crack;
  TextEditingController season = new TextEditingController(text: "");
  DeniedNotVerify(this.dto, this.crack);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Denied crack",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Montserrat",
                          color: Colors.white),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                Text(
                                  "ID: " + crack.crackId.toString(),
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                Text(crack.position.toString(),
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: Colors.deepOrange,
                                ),
                                Text(crack.created,
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: FlatButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: Colors.blueAccent,
                                    onPressed: () async {
                                      CrackRepository crackRepo =
                                          new CrackRepository();
                                      String result = await crackRepo
                                          .deleteCrack(crack.crackId);
                                      if (result != null &&
                                          result.contains(
                                              "Delete crack success")) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CrackScreen(dto: dto)),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Denied",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: FlatButton(
                                    color: Colors.blueGrey,
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: Colors.blueAccent,
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text(
                                      "Cancel",
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
        ));
  }
}
