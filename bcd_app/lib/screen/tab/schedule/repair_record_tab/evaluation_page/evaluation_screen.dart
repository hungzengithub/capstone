import 'dart:collection';

import 'package:bcd_app/objects/crackEvaluationDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/dialog/noti_dialog.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:bcd_app/screen/tab/schedule/component/evaluation_crack_component.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'evaluation_complete.dart';

class EvalutationScreen extends StatefulWidget {
  final UserDTO dto;
  final MaintainanceDTO maintainance;
  EvalutationScreen(this.dto, this.maintainance);
  @override
  State<StatefulWidget> createState() {
    return _evalutationScreenState();
  }
}

// ignore: camel_case_types
class _evalutationScreenState extends State<EvalutationScreen> {
  HashMap<int, CrackEvaluationDTO> map = HashMap<int, CrackEvaluationDTO>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ILLUSTRATION_BLUE_COLOR_DRAWER.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Evaluation Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Evaluate for each crack in list maintenance",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      )),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enableInfiniteScroll: false,
              ),
              items: widget.maintainance.cracks.map((crack) {
                return Builder(
                  builder: (BuildContext context) {
                    return EvaluationComponent(crack, map);
                  },
                );
              }).toList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 120),
              child: FlatButton(
                  color: Color(0xfff58772),
                  onPressed: () async {
                    if (map.length == widget.maintainance.cracks.length) {
                      double sum = 0;
                      List<CrackEvaluationDTO> list =
                          new List<CrackEvaluationDTO>();
                      for (CrackEvaluationDTO dto in map.values) {
                        sum += dto.assessmentResult;
                        list.add(dto);
                      }
                      sum = sum / list.length;
                      int average = (sum).toInt();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EvaluationComplete(
                                  widget.dto,
                                  widget.maintainance,
                                  list,
                                  average,
                                )),
                      );
                    } else {
                      Flushbar(
                        message: APPMESSAGE.EVALUATE_CRACK_FAIL,
                        duration: Duration(seconds: 1),
                      )..show(context);
                    }
                  },
                  child: Text("Next", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
