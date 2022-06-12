import 'package:bcd_app/objects/crackEvaluationDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../manage_schedule_screen.dart';

class EvaluationSumup extends StatefulWidget {
  final UserDTO dto;
  final MaintainanceDTO maintainance;
  final List<CrackEvaluationDTO> listCrack;
  final int average;
  EvaluationSumup(this.dto, this.maintainance, this.listCrack, this.average);
  @override
  State<StatefulWidget> createState() {
    return _evaluationSumupState();
  }
}

// ignore: camel_case_types
class _evaluationSumupState extends State<EvaluationSumup> {
  TextEditingController des = new TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
  }

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
                    color: Colors.teal,
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
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
                              SizedBox(
                                width: 24,
                              ),
                              Container(
                                  child: Text(
                                "Evaluation Detail",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )),
                              Spacer(),
                              SizedBox(
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(1, 10), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Repair evaluation',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20, bottom: 10, top: 30),
                        child: Row(
                          children: [
                            Icon(
                              Icons.qr_code,
                              size: 20,
                              color: Colors.blue,
                            ),
                            Text(
                              'RepairRecordID: ' +
                                  widget.maintainance.maintenanceOrderId
                                      .toString(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 20,
                              color: Colors.blueGrey,
                            ),
                            Text(
                              "Repairer - " +
                                  widget.maintainance.maintenanceWorkerName,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            )
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
                              color: Colors.yellow[400],
                            ),
                            Text(
                              "Repairing Date - " +
                                  widget.maintainance.maintenanceDate
                                      .split(".")
                                      .first
                                      .replaceAll("T", " "),
                              style: TextStyle(
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
                              color: Colors.yellow[400],
                            ),
                            Text(
                              "Rating Average - " + widget.average.toString(),
                              style: TextStyle(
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
                        height: 50,
                        child: TextFormField(
                          controller: des,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          style: TextStyle(color: Colors.black54),
                          minLines: 1,
                          maxLength: 200,
                          decoration: InputDecoration(
                              fillColor: Colors.red,
                              labelText: 'Description',
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
                                  color: Colors.deepPurpleAccent)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                            color: Colors.teal,
                            onPressed: () async {
                              MaintainanceRepository repo =
                                  new MaintainanceRepository();
                              String result = await repo.evaluate(
                                widget.average,
                                widget.maintainance.maintenanceOrderId,
                                widget.listCrack,
                                des.text,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScheduleScreen(
                                          selectedTab: 3,
                                          dto: widget.dto,
                                        )),
                              );
                            },
                            child: Text("Confirm",
                                style: TextStyle(color: Colors.white))),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
