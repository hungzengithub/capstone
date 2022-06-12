import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../../crack_screen.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Color color;
  final int crackId;
  final String posDetail;
  final String description;
  final String severity;
  final UserDTO dto;
  final CrackDTO crack;
  ConfirmDialog(this.title, this.message, this.color, this.crackId,
      this.posDetail, this.description, this.severity, this.dto, this.crack);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Column(
            children: [
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
                            Text(
                              message,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 110,
                                    child: FlatButton(
                                      color: Color(0xfffab696),
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(8.0),
                                      splashColor: Colors.blueAccent,
                                      onPressed: () async {
                                        CrackRepository crackRepo =
                                            new CrackRepository();
                                        String result =
                                            await crackRepo.updateVerifyCrack(
                                                crackId,
                                                description,
                                                severity,
                                                posDetail);
                                        if (result != null &&
                                            result.contains(
                                                "Update crack success")) {
                                          if (severity == CrackSeverity.High &&
                                              crack.severity !=
                                                  CrackSeverity.High) {
                                            List<int> listCrack =
                                                new List<int>();
                                            listCrack.add(crack.crackId);
                                            await crackRepo
                                                .addToQueue(listCrack);
                                          } else if (severity ==
                                                  CrackSeverity.Low &&
                                              crack.maintenanceOrderId != -1) {
                                            List<int> listRemove =
                                                new List<int>();
                                            listRemove.add(crack.crackId);
                                            String result = await crackRepo
                                                .removeFromQueue(listRemove);
                                          }
                                          String message = "Crack " +
                                              crackId.toString() +
                                              " has been updated successfully";
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CrackScreen(
                                                          flushBarMessage:
                                                              message,
                                                          dto: dto,
                                                          page: 1)),
                                              (Route<dynamic> route) =>
                                                  route.isFirst);
                                        } else {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          Flushbar(
                                            message:
                                                APPMESSAGE.UPDATE_CRACK_FAIL,
                                            duration: Duration(seconds: 2),
                                          )..show(context);
                                        }
                                      },
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 110,
                                    child: FlatButton(
                                      color: ILLUSTRATION_GREY_HIGH_COLOR,
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      padding: EdgeInsets.all(8.0),
                                      splashColor: Colors.blueAccent,
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300),
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
