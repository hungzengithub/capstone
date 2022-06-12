import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../manage_schedule_screen.dart';

class BottomSheetUnSchedule extends StatefulWidget {
  List<CrackDTO> listCrackInQueue;
  List<int> listInQueue;
  final UserDTO dto;
  final Function() callback;

  BottomSheetUnSchedule(
      this.listInQueue, this.listCrackInQueue, this.dto, this.callback);
  @override
  State<StatefulWidget> createState() {
    return __ScheduleDetailState();
  }
}

class __ScheduleDetailState extends State<BottomSheetUnSchedule> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    child: Text("Cancel",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text("Add to queue",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black54)),
                    onPressed: () async {
                      CrackRepository crackRepo = new CrackRepository();
                      if (widget.listCrackInQueue.length > 0) {
                        String result =
                            await crackRepo.addToQueue(widget.listInQueue);
                        if (result.contains("failed"))
                          result = APPMESSAGE.ADD_TO_QUEUE_FAIL;
                        else
                          result = APPMESSAGE.ADD_TO_QUEUE_SUCCESS;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduleScreen(
                                      selectedTab: 1,
                                      dto: widget.dto,
                                      flushBarMessage: result,
                                    )),
                            (Route<dynamic> route) => route.isFirst);
                      }
                    })
              ],
            )),
            Container(
              height: 200,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: widget.listCrackInQueue.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height: 190,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300].withOpacity(1),
                                      spreadRadius: 4,
                                      blurRadius: 10,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) => ViewImageDetai(
                                                    image: widget
                                                        .listCrackInQueue[index]
                                                        .image)));
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(widget
                                                      .listCrackInQueue[index]
                                                      .imageThumbnails)))),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                  "Crack " +
                                                      widget
                                                          .listCrackInQueue[
                                                              index]
                                                          .crackId
                                                          .toString(),
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Icon(Icons.home_repair_service,
                                                    color:
                                                        ILLUSTRATION_PINK_COLOR,
                                                    size: 18),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Severity",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 40),
                                                Text(
                                                  widget.listCrackInQueue[index]
                                                      .severity,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Icon(Icons.warning_amber_sharp,
                                                    color:
                                                        ILLUSTRATION_PINK_COLOR,
                                                    size: 18),
                                                SizedBox(width: 10),
                                                Text(
                                                  "Created Date",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 40),
                                                Container(
                                                  width: 135,
                                                  child: Text(
                                                    convertTime(widget
                                                            .listCrackInQueue[
                                                                index]
                                                            .createdDate ??
                                                        DateTime.now()),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w300,
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
                                                                  crack: widget
                                                                          .listCrackInQueue[
                                                                      index],
                                                                  dto: widget
                                                                      .dto)),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Detail",
                                                    style: TextStyle(
                                                        color:
                                                            ILLUSTRATION_PINK_COLOR,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      widget.listInQueue.remove(
                                                          widget
                                                              .listCrackInQueue[
                                                                  index]
                                                              .crackId);
                                                      widget.listCrackInQueue
                                                          .remove(widget
                                                                  .listCrackInQueue[
                                                              index]);
                                                      widget.callback();
                                                    });
                                                  },
                                                  child: Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 13),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                      ],
                    );
                  }),
            ),
          ],
        ));
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

  String convertTime(DateTime date) {
    String tmp = DateFormat('hh').format(date) +
        " : " +
        DateFormat('ss').format(date) +
        ", " +
        DateFormat('EEEE').format(date) +
        ", " +
        DateFormat('MMMM').format(date) +
        " " +
        date.day.toString() +
        ", " +
        date.year.toString();
    return tmp;
  }
}
