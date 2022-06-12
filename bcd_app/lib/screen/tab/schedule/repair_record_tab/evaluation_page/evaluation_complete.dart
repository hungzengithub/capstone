import 'package:bcd_app/objects/crackEvaluationDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../manage_schedule_screen.dart';

class EvaluationComplete extends StatefulWidget {
  final UserDTO dto;
  final MaintainanceDTO maintainance;
  final List<CrackEvaluationDTO> listCrack;
  final int average;
  EvaluationComplete(this.dto, this.maintainance, this.listCrack, this.average);
  @override
  State<StatefulWidget> createState() {
    return _evaluationSumupState();
  }
}

// ignore: camel_case_types
class _evaluationSumupState extends State<EvaluationComplete> {
  TextEditingController des = new TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

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
                        "Repair Evaluation",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Check infomation below and complete your evaluation",
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
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin:
                              EdgeInsets.only(left: 20, bottom: 10, top: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 20,
                                color: ILLUSTRATION_BLUE_COLOR,
                              ),
                              SizedBox(width: 20),
                              Text(
                                'RepairRecordID - ',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget?.maintainance?.maintenanceOrderId
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, bottom: 10),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Icon(
                                Icons.work,
                                size: 20,
                                color: ILLUSTRATION_BLUE_COLOR,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Repairer - ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget?.maintainance?.maintenanceWorkerName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, bottom: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range_sharp,
                                size: 20,
                                color: ILLUSTRATION_BLUE_COLOR,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Repairing Date - ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget?.maintainance?.maintenanceDate
                                    ?.split(".")
                                    ?.first,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rate,
                                size: 20,
                                color: ILLUSTRATION_BLUE_COLOR,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Rating Average - ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget?.average.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: des,
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 100,
                            maxLines: 10,
                            minLines: 1,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(color: Colors.black54),
                            decoration: InputDecoration(
                                fillColor: Colors.red,
                                labelText: "Description",
                                labelStyle: TextStyle(fontSize: 13),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                border: new UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red)),
                                icon: Icon(Icons.rate_review,
                                    color: ILLUSTRATION_BLUE_COLOR)),
                          ),
                        ),
                        Container(
                          width: 120,
                          margin: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                              color: Color(0xfff58d82),
                              onPressed: () async {
                                MaintainanceRepository repo =
                                    new MaintainanceRepository();
                                String result = await repo.evaluate(
                                  widget?.average ?? 0,
                                  widget?.maintainance?.maintenanceOrderId ?? 0,
                                  widget?.listCrack,
                                  des?.text ?? '',
                                );
                                if (result.contains("success")) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScheduleScreen(
                                              flushBarMessage: APPMESSAGE
                                                  .UPDATE_REPAIR_SUCCESS,
                                              selectedTab: 3,
                                              dto: widget.dto,
                                            )),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScheduleScreen(
                                              flushBarMessage:
                                                  APPMESSAGE.UPDATE_REPAIR_FAIL,
                                              selectedTab: 2,
                                              dto: widget.dto,
                                            )),
                                  );
                                }
                              },
                              child: Text("Confirm",
                                  style: TextStyle(color: Colors.white))),
                        ),
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
