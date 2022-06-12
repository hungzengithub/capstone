import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'history_carousel_container.dart';
import 'history_result.dart';

class HistoryBox extends StatefulWidget {
  final MaintainanceDTO maintenance;
  final UserDTO dto;
  HistoryBox(this.dto, this.maintenance);
  @override
  State<StatefulWidget> createState() {
    return _HistoryBoxState();
  }
}

class _HistoryBoxState extends State<HistoryBox> {
  String currentCrackView;
  @override
  void initState() {
    super.initState();
    currentCrackView = "1/" + widget.maintenance.cracks.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HistoryResult(
                        dto: widget.dto,
                        maintenance: widget.maintenance,
                      )),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Row(
                children: [
                  Opacity(
                    opacity: 0.501960813999176,
                    child: Container(
                        width: 30,
                        margin: EdgeInsets.only(left: 10, right: 5, top: 20),
                        height: 1.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.blue[500],
                              width: 0.8,
                            ))),
                  ),
                  Container(
                    height: 60,
                    child: Text(
                        concatTime(widget.maintenance.maintenanceDate ??
                            "2021-05-01 00:00:00"),
                        style: TextStyle(fontSize: 50)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Total cracks: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: widget?.maintenance?.cracks?.length
                                          .toString() ??
                                      "N/A",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        Container(
                            width: 180,
                            child: RichText(
                              text: TextSpan(
                                text: 'Repairer: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: widget.maintenance
                                              ?.maintenanceWorkerName ??
                                          "N/A",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Assessor result: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget?.maintenance?.assessmentResult
                                  .toString() ??
                              "" + "/100",
                          style: TextStyle(fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Assessor: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: widget?.maintenance?.assessorName ?? "",
                          style: TextStyle(fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              onPageChanged: (index, reason) {
                setState(() {
                  currentCrackView = (index + 1).toString() +
                      "/" +
                      widget.maintenance.cracks.length.toString();
                });
              }),
          items: widget.maintenance.cracks.map((crack) {
            return Builder(
              builder: (BuildContext context) {
                return HistoryCarouselContainer(
                  crack: crack,
                  dto: widget.dto,
                  maintenanceOrderId: widget.maintenance.maintenanceOrderId,
                );
              },
            );
          }).toList(),
        ),
        Center(child: Text(currentCrackView, style: TextStyle(fontSize: 16)))
      ],
    ));
  }

  String concatTime(String time) {
    String returnTime;
    returnTime = time.split(" ").last;
    returnTime = returnTime.substring(0, returnTime.length - 3);
    print(returnTime);
    return returnTime;
  }
}
