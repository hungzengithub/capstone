import 'dart:collection';

import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/crackEvaluationDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class EvaluationComponent extends StatefulWidget {
  CrackDTO crack;
  HashMap<int, CrackEvaluationDTO> map;
  EvaluationComponent(this.crack, this.map);
  @override
  State<StatefulWidget> createState() {
    return __EvaluationComponentState();
  }
}

class __EvaluationComponentState extends State<EvaluationComponent> {
  bool isDone = false;
  int valueHolder = 1;
  Color color = Colors.grey;
  TextEditingController des = new TextEditingController(text: "");
  TextEditingController rating = new TextEditingController(text: "1");
  @override
  initState() {
    super.initState();
    if (widget.map.containsKey(widget.crack.crackId)) {
      isDone = true;
      valueHolder = widget.map[widget.crack.crackId].assessmentResult;
      if (valueHolder > 80) {
        color = Colors.green;
      } else if (valueHolder > 50) {
        color = Colors.yellow;
      } else if (valueHolder > 25) {
        color = Colors.orangeAccent;
      } else
        color = Colors.red;
      rating = new TextEditingController(
        text: valueHolder.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => ViewImageDetai(
                                image: widget.crack?.image ?? "")));
                      },
                      child: Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.crack.imageThumbnails),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20),
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
                                    'ID: ' + widget.crack.crackId.toString(),
                                    style: TextStyle(
                                        color: Colors.black87,
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
                                    Icons.report_problem,
                                    size: 20,
                                    color: widget.crack.severity ==
                                            CrackSeverity.Low
                                        ? Color.fromRGBO(255, 215, 0, 1)
                                        : widget.crack.severity ==
                                                CrackSeverity.Medium
                                            ? Colors.orangeAccent
                                            : Colors.redAccent,
                                  ),
                                  Text(
                                    widget.crack.severity,
                                    style: TextStyle(
                                        color: widget.crack.severity ==
                                                CrackSeverity.Low
                                            ? Color.fromRGBO(255, 215, 0, 1)
                                            : widget.crack.severity ==
                                                    CrackSeverity.Medium
                                                ? Colors.orangeAccent
                                                : Colors.redAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              child: TextFormField(
                controller: des,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Tap to input description',
                    labelStyle: TextStyle(fontSize: 13),
                    icon: Icon(Icons.rate_review,
                        color: Colors.deepPurpleAccent)),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              child: TextFormField(
                controller: rating,
                readOnly: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixText: "/100",
                    fillColor: Colors.red,
                    labelText: 'Rating',
                    icon: Icon(Icons.star_rate, color: Colors.yellow)),
              ),
            ),
            Container(
                child: Slider(
                    value: valueHolder.toDouble(),
                    min: 1,
                    max: 100,
                    divisions: 100,
                    activeColor: color,
                    inactiveColor: Colors.grey[100],
                    label: '${valueHolder.round()}',
                    onChanged: (double newValue) {
                      setState(() {
                        valueHolder = newValue.round();
                        if (valueHolder > 80) {
                          color = Colors.green;
                        } else if (valueHolder > 50) {
                          color = Colors.yellow;
                        } else if (valueHolder > 25) {
                          color = Colors.orangeAccent;
                        } else
                          color = Colors.red;
                        rating.text = valueHolder.toString();
                        if (widget.map.containsKey(widget.crack.crackId) ==
                            true) {
                          widget.map.remove(widget.crack.crackId);
                        }
                        isDone = false;
                      });
                    },
                    semanticFormatterCallback: (double newValue) {
                      return '${newValue.round()}';
                    })),
            Container(
              height: 40,
              child: FlutterSwitch(
                activeText: "Done",
                inactiveText: "Not yet",
                inactiveIcon: Icon(Icons.pending),
                activeIcon: Icon(Icons.done),
                activeColor: Colors.green,
                inactiveColor: Colors.blueGrey,
                value: isDone,
                valueFontSize: 10.0,
                width: 110,
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    isDone = val;
                    int point = int.tryParse(rating.text) ?? 0;
                    CrackEvaluationDTO dto = new CrackEvaluationDTO(
                        widget.crack.crackId,
                        point,
                        des.text,
                        point > 40
                            ? CrackStatus.Fixed
                            : CrackStatus.UnqualifiedRepair);
                    if (!widget.map.containsKey(widget.crack.crackId)) {
                      widget.map.putIfAbsent(dto.crackId, () => dto);
                    } else
                      widget.map.update(dto.crackId, (value) => value = dto);
                  });
                },
              ),
            )
          ],
        ));
  }
}
