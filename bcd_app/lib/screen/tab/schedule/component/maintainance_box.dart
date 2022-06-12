import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/repair_record_detail/repair_record_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'queue_carousel_container.dart';

class MaintainanceBox extends StatefulWidget {
  final MaintainanceDTO maintenance;
  final UserDTO dto;
  MaintainanceBox(this.dto, this.maintenance);
  @override
  State<StatefulWidget> createState() {
    return __MaintainanceBoxtate();
  }
}

class __MaintainanceBoxtate extends State<MaintainanceBox> {
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
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RepairRecordDetail(
                      dto: widget.dto, maintenance: widget.maintenance)),
            );
          },
          child: Container(
              child: Row(
            children: [
              Opacity(
                opacity: 0.501960813999176,
                child: Container(
                    width: 30,
                    margin: EdgeInsets.only(left: 10, right: 5),
                    height: 1.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.blue[500],
                          width: 0.8,
                        ))),
              ),
              Text(
                  concatTime(widget.maintenance.maintenanceDate ??
                      "2021-05-01 00:00:00"),
                  style: TextStyle(
                    fontSize: 50,
                  )),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
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
                              style: TextStyle(fontWeight: FontWeight.w300)),
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
                                text: widget
                                        ?.maintenance?.maintenanceWorkerName ??
                                    "N/A",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
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
                return QueueCarouselContainer(
                    maintenanceOrderId: widget.maintenance.maintenanceOrderId,
                    canRemove: false,
                    crack: crack,
                    callback: null,
                    dto: widget.dto);
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
