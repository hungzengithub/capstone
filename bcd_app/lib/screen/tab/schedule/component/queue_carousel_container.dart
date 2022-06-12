import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_scheduled_detail/crack_schedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/loop_carousel.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QueueCarouselContainer extends StatefulWidget {
  final CrackDTO crack;
  final Function() callback;
  final bool canRemove;
  final UserDTO dto;
  final int maintenanceOrderId;
  const QueueCarouselContainer(
      {Key key,
      this.crack,
      this.callback,
      this.canRemove,
      this.dto,
      this.maintenanceOrderId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __QueueCarouselContainerState();
  }
}

class __QueueCarouselContainerState extends State<QueueCarouselContainer> {
  @override
  Widget build(BuildContext context) {
    return LoopCarousel(
      allowRemove: widget.canRemove,
      child: Container(
        height: 180,
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              height: 170,
              margin: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onLongPress: () {
                  // widget.callback();
                },
                child: FlipCard(
                  flipOnTouch: true,
                  direction: FlipDirection.HORIZONTAL, // default
                  back: Container(
                      height: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300].withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset:
                                  Offset(1, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage(widget.crack.imageThumbnails)))),
                  front: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300].withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(1, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                                "Crack " + widget?.crack?.crackId.toString() ??
                                    "N/A",
                                style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(height: 5),
                          Container(
                              child: Row(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Icon(Icons.home_repair_service,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 18),
                                        SizedBox(width: 10),
                                        Text(
                                          "Status",
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
                                          widget.crack.status.split(" ").first,
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
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 18),
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
                                          widget.crack.severity,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  child: TextButton(
                                    onPressed: () {
                                      if (widget.crack.status.contains(
                                          CrackStatus
                                              .UnscheduledForMaintenace)) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UnScheduleDetail(
                                                      crack: widget.crack,
                                                      dto: widget.dto)),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ScheduledDetail(
                                                  maintenanceOrderId: widget
                                                          .maintenanceOrderId ??
                                                      1,
                                                  crack: widget.crack,
                                                  dto: widget.dto)),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Detail",
                                      style: TextStyle(
                                          color: ILLUSTRATION_BLUE_COLOR,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.calendar_today_rounded,
                                  color: ILLUSTRATION_PINK_COLOR, size: 18),
                              SizedBox(width: 10),
                              Text(
                                "Created Date",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(width: 40),
                              Text(
                                widget?.crack?.created ?? "N/A",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            widget.canRemove
                ? Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        print("xx");
                      },
                      child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300].withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset:
                                    Offset(1, 2), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Center(child: Icon(Icons.close, size: 18))),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
