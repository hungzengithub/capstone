import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnScheduleBox extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;

  const UnScheduleBox({Key key, this.crack, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UnScheduleBoxState();
  }
}

class _UnScheduleBoxState extends State<UnScheduleBox> {
  String buttonValue;
  Color buttonColor;
  @override
  void initState() {
    super.initState();
    if (widget.crack.maintenanceOrderId == -1) {
      buttonValue = "Add";
      buttonColor = Colors.orange;
    } else {
      buttonValue = "queue added";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 15, top: 10, right: 10),
        child: Row(
          children: [
            // DottedLine(
            //   dashLength: 50,
            //   dashGapLength: 5,
            //   lineThickness: 2,
            //   dashColor: ILLUSTRATION_BLUE_COLOR,
            //   direction: Axis.vertical,
            //   lineLength: 160,
            // ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                  height: 165,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) =>
                                  ViewImageDetai(image: widget.crack.image)));
                          // showDialog(
                          //     context: context,
                          //     builder: (_) => Dialog(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Container(
                          //             height: 300,
                          //             color: Colors.red.withOpacity(0),
                          //             child: PhotoView(
                          //               minScale: 0.07,
                          //               maxScale: 1.1,
                          //               backgroundDecoration: BoxDecoration(
                          //                   color: Colors.red.withOpacity(0)),
                          //               imageProvider: NetworkImage(crack.image),
                          //             ))));
                        },
                        child: Container(
                            height: double.infinity,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.crack.imageThumbnails)))),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                    "Crack " + widget.crack.crackId.toString(),
                                    style: TextStyle(fontSize: 16)),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.home_repair_service,
                                      color: ILLUSTRATION_PINK_COLOR, size: 18),
                                  SizedBox(width: 10),
                                  Text(
                                    "Severity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Text(
                                    widget.crack.severity ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Icon(Icons.warning_amber_sharp,
                                      color: ILLUSTRATION_PINK_COLOR, size: 18),
                                  SizedBox(width: 10),
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 40),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      convertTime(widget.crack.createdDate ??
                                          DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UnScheduleDetail(
                                                    crack: widget.crack,
                                                    dto: widget.dto)),
                                      );
                                    },
                                    child: Text(
                                      "Detail",
                                      style: TextStyle(
                                          color: ILLUSTRATION_PINK_COLOR,
                                          fontSize: 13),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (widget.crack.maintenanceOrderId !=
                                          -1) {
                                        //do nothing
                                      } else {
                                        List<int> listCrack = new List<int>();
                                        listCrack.add(widget.crack.crackId);
                                        CrackRepository crackRepo =
                                            new CrackRepository();
                                        setState(() {
                                          buttonValue = "queue added";
                                          buttonColor = Colors.black54;
                                          widget.crack.maintenanceOrderId = -2;
                                        });
                                        if (listCrack.length > 0) {
                                          String result = await crackRepo
                                              .addToQueue(listCrack);
                                          if (result.contains("failed"))
                                            result =
                                                APPMESSAGE.ADD_TO_QUEUE_FAIL;
                                          else
                                            result =
                                                APPMESSAGE.ADD_TO_QUEUE_SUCCESS;
                                          Flushbar(
                                            message: result,
                                            duration: Duration(seconds: 2),
                                          )..show(context);
                                        }
                                      }
                                    },
                                    child: Text(
                                      buttonValue,
                                      style: TextStyle(
                                          color: buttonColor, fontSize: 13),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}

String convertTime(DateTime date) {
  String tmp =
      DateFormat('hh').format(date) + " : " + DateFormat('ss').format(date);
  return tmp;
}
