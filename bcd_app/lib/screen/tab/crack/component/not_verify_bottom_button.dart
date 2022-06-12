import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/Input_not_verify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'denied_not_verify.dart';

class NotVerifyBottomButton extends StatelessWidget {
  final UserDTO dto;
  final CrackDTO crack;
  NotVerifyBottomButton(this.crack, this.dto);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Text(
                    'ID:' + crack.crackId.toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 20,
                    color: Colors.green,
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      crack.position,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            ),
            Container(
                child: Row(
              children: [
                Container(
                  height: 30,
                  width: 70,
                  child: FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InputNotVerify(crack, dto),
                        ),
                      );
                    },
                    child: Text(
                      "Approved",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: FlatButton(
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.blueAccent,
                    onPressed: () {
                      showDialog(
                        context: context,
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: DeniedNotVerify(dto, crack),
                        ),
                      );
                    },
                    child: Text(
                      "Denined",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}
