import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'history_carousel_container.dart';

class HistoryResult extends StatefulWidget {
  final MaintainanceDTO maintenance;
  final UserDTO dto;
  HistoryResult({@required this.maintenance, @required this.dto});
  @override
  _HistoryResultState createState() => _HistoryResultState();
}

class _HistoryResultState extends State<HistoryResult> {
  ScrollController _scrollController = ScrollController();
  String title = "";
  String currentCrackView;
  final formatCurrency = new NumberFormat.simpleCurrency();
  @override
  void initState() {
    super.initState();
    title =
        "Repair record " + widget.maintenance.maintenanceOrderId.toString() ??
            "N/A";
    currentCrackView = "1/" + widget.maintenance.cracks.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: NotificationListener<ScrollNotification>(
                // ignore: missing_return
                onNotification: (scrollNotification) {},
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Repair result",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 10),
                                      child: Container(
                                        height: 1.0,
                                        color: ILLUSTRATION_BLUE_COLOR_2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.code_outlined,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Assessment result",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.maintenance?.assessmentResult.toString() +
                                      "/100" ??
                                  "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.account_box,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Assessor",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.maintenance?.assessorName ?? "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.home_repair_service_outlined,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Repairer",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.maintenance?.maintenanceWorkerName ??
                                  "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.monetization_on_outlined,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              formatCurrency.format(
                                  widget.maintenance?.maintenanceExpense),
                              // widget.maintenance?.maintenanceExpense
                              //         .toString() ??
                              //     "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.today_outlined,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Repair date",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.maintenance.maintenanceDate ?? "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.tour_outlined,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.maintenance.status,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "List cracks",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 10),
                                      child: Container(
                                        height: 1.0,
                                        color: ILLUSTRATION_BLUE_COLOR_2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                        widget.maintenance.cracks.length
                                            .toString();
                                  });
                                }),
                            items: widget.maintenance.cracks.map((crack) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return HistoryCarouselContainer(
                                    crack: crack,
                                    dto: widget.dto,
                                    maintenanceOrderId:
                                        widget.maintenance.maintenanceOrderId,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Center(
                              child: Text(currentCrackView,
                                  style: TextStyle(fontSize: 16)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
