import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';

class CrackVerifyBox extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final bool isAdd;
  final List<int> listCrack;

  CrackVerifyBox(this.dto, this.isAdd, this.crack, this.listCrack);
  @override
  State<StatefulWidget> createState() {
    return CrackVerifyBoxState(crack);
  }
}

class CrackVerifyBoxState extends State<CrackVerifyBox> {
  CrackDTO crack;
  CrackVerifyBoxState(this.crack);
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300].withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(1, 10), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Container(
                    child: Row(
                  children: [
                    Container(
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(crack.image),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                    ),
                    VerifyInfo(
                      crack,
                    ),
                  ],
                )),
                Positioned(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          Container(
                            width: 110,
                            height: 20,
                            margin: EdgeInsets.only(right: 0, top: 0),
                            decoration: BoxDecoration(
                              color: crack.status == CrackStatus.Fixed
                                  ? Colors.green[600]
                                  : crack.status ==
                                          CrackStatus.ScheduledForMaintenace
                                      ? SCHEDULED_COLOR
                                      : UNSCHEDULED_COLOR,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  crack.status == CrackStatus.Fixed
                                      ? Icons.done
                                      : crack.status ==
                                              CrackStatus.ScheduledForMaintenace
                                          ? Icons.hardware
                                          : Icons.close_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                Text(
                                  crack.status.split(" ").first,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                widget.isAdd
                    ? Positioned(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 120),
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                ),
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isChecked = value;
                                      if (isChecked) {
                                        widget.listCrack
                                            .add(widget.crack.crackId);
                                      } else {
                                        widget.listCrack.remove(widget.crack);
                                      }
                                    });
                                  },
                                ))))
                    : Container(),
              ],
            )));
  }
}

class VerifyInfo extends StatelessWidget {
  final CrackDTO crack;
  VerifyInfo(this.crack);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Text(
                    'ID: ' + crack.crackId.toString(),
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 20,
                    color: Colors.blueAccent,
                  ),
                  Text(
                    crack.position,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.report_problem,
                    size: 20,
                    color: crack.severity == CrackSeverity.Low
                        ? Color.fromRGBO(255, 215, 0, 1)
                        : crack.severity == CrackSeverity.Medium
                            ? Colors.orangeAccent
                            : Colors.redAccent,
                  ),
                  Text(
                    crack.severity ?? "N/A",
                    style: TextStyle(
                        color: crack.severity == CrackSeverity.Low
                            ? Color.fromRGBO(255, 215, 0, 1)
                            : crack.severity == CrackSeverity.Medium
                                ? Colors.orangeAccent
                                : Colors.redAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
