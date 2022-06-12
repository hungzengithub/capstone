import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/verify_tab/crack_verify_box.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../manage_schedule_screen.dart';

class BottomSheetCrack extends StatefulWidget {
  final List<CrackDTO> listCrack;
  final UserDTO dto;
  final bool isQueue;
  BottomSheetCrack(this.listCrack, this.dto, this.isQueue);
  @override
  State<StatefulWidget> createState() {
    return bottomSheetCrackState();
  }
}

// ignore: camel_case_types
class bottomSheetCrackState extends State<BottomSheetCrack> {
  String _remove = "Remove";
  bool _visable = false;
  bool isAdd = false;
  List<int> listRemove = new List<int>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.isQueue == true
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_remove == "Remove") {
                                  _visable = true;
                                  _remove = "Unselect";
                                  isAdd = true;
                                } else {
                                  _visable = false;
                                  _remove = "Remove";
                                  isAdd = false;
                                }
                              });
                            },
                            child: Container(
                                child: Text(_remove,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)))),
                        Visibility(
                          visible: _visable,
                          child: GestureDetector(
                              onTap: () async {
                                if (listRemove.length < 1) {
                                  Flushbar(
                                    message: "No crack is selected",
                                    duration: Duration(seconds: 1),
                                  )..show(context);
                                } else {
                                  CrackRepository repo = new CrackRepository();
                                  String result =
                                      await repo.removeFromQueue(listRemove);
                                  if (result != null) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleScreen(
                                                  dto: widget.dto,
                                                  selectedTab: 1,
                                                  flushBarMessage: APPMESSAGE
                                                      .REMOVE_FROM_QUEUE_SUCCESS,
                                                )),
                                        (Route<dynamic> route) =>
                                            route.isFirst);
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleScreen(
                                                  dto: widget.dto,
                                                  selectedTab: 1,
                                                  flushBarMessage: APPMESSAGE
                                                      .REMOVE_FROM_QUEUE_FAIL,
                                                )),
                                        (Route<dynamic> route) =>
                                            route.isFirst);
                                  }
                                }
                              },
                              child: Container(
                                  child: Text("Remove",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)))),
                        ),
                      ],
                    ),
                  )
                : Container(),
            Container(
              height: widget.isQueue == true ? 220 : 300,
              child: ListView.builder(
                  itemCount: widget.listCrack.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerDate(index, widget.listCrack),
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: CrackVerifyBox(
                            widget.dto,
                            isAdd,
                            widget.listCrack[index],
                            listRemove,
                          ),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                                caption: 'View Detail',
                                color: Colors.grey[400],
                                foregroundColor: Colors.white,
                                icon: Icons.grid_view,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UnScheduleDetail(
                                                crack: widget.listCrack[index],
                                                dto: widget.dto,
                                              )));
                                }),
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerDate(int index, List<CrackDTO> listDTO) {
    if (index == 0 ||
        listDTO[index].createdDate.day != listDTO[index - 1].createdDate.day)
      return Container(
          width: 80,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1, 10), // changes position of shadow
              ),
            ],
            color: Colors.teal,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          margin: EdgeInsets.only(left: 20, top: 5, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                listDTO[index].created.split(" ").first,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ));
    return Container();
  }
}
