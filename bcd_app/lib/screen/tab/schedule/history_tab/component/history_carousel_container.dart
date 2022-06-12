import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_fixed_detail/crack_fixed_detail.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCarouselContainer extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final int maintenanceOrderId;
  HistoryCarouselContainer(
      {Key key, this.crack, this.dto, this.maintenanceOrderId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HistoryCarouselContainerState();
  }
}

class _HistoryCarouselContainerState extends State<HistoryCarouselContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 170,
            margin: EdgeInsets.only(top: 10),
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
                          offset: Offset(1, 2), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.crack.imageThumbnails)))),
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
                                      "Assessment result",
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
                                      widget.crack.assessmentResult.toString() +
                                          " /100",
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
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Container(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FixedDetail(
                                              crack: widget.crack,
                                              dto: widget.dto,
                                              maintenanceOrderId:
                                                  widget.maintenanceOrderId)));
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
                            convertDate(
                                widget?.crack?.createdDate ?? DateTime.now()),
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
        ],
      ),
    );
  }

  String convertDate(DateTime date) {
    String tmp = DateFormat('EEEE').format(date) +
        ", " +
        DateFormat('MMMM').format(date) +
        " " +
        date.day.toString() +
        ", " +
        date.year.toString();
    return tmp;
  }
}
