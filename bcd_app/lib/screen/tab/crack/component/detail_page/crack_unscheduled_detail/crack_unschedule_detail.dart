import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/screen/tab/schedule/manage_schedule_screen.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'confirm_dialog.dart';

class UnScheduleDetail extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;

  const UnScheduleDetail({Key key, this.crack, this.dto}) : super(key: key);
  @override
  _MemberDetailScreenState createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<UnScheduleDetail> {
  ScrollController _scrollController = ScrollController();
  double _bottomValue = 0;
  String _serverity = CrackSeverity.Low;
  TextEditingController _posDetail = new TextEditingController(text: "");
  TextEditingController _description = new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _posDetail = new TextEditingController(text: widget.crack.position);
    _description = new TextEditingController(text: widget.crack.description);
    _serverity = widget.crack.severity ?? CrackSeverity.Low;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          "CRACK DETAIL",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: NotificationListener<ScrollNotification>(
                // ignore: missing_return
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                    setState(() {
                      _bottomValue = -60;
                    });
                  } else if (scrollNotification is ScrollEndNotification) {
                    setState(() {
                      _bottomValue = 0;
                    });
                  }
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ViewImageDetai(
                                      image: widget.crack.image)));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.crack.imageThumbnails)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Crack Infomation",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ILLUSTRATION_BLUE_COLOR_2,
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
                                    "CrackID",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.crack.crackId.toString() ?? "",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.perm_device_information,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Accuracy",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              MyUtil.convertToPercent(
                                  widget.crack?.accuracy ?? 0),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.date_range,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Created Date",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.crack.created ?? "N/A",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color: ILLUSTRATION_PINK_COLOR, size: 16),
                                  SizedBox(width: 10),
                                  Text(
                                    "Last modified",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 57.0),
                            child: Text(
                              widget.crack.lastModified ?? "N/A",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Update crack",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ILLUSTRATION_BLUE_COLOR_2,
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
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Severity",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 35,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ILLUSTRATION_BLUE_COLOR_2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  value: _serverity,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _serverity = newValue;
                                    });
                                  },
                                  items: ["High", "Medium", "Low"].map((value) {
                                    return DropdownMenuItem(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: new Text(
                                          value,
                                          style: TextStyle(),
                                        ),
                                      ),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Position detail",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ILLUSTRATION_BLUE_COLOR_2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: _posDetail,
                              onChanged: (text) {},
                              minLines: 1,
                              maxLines: 5,
                              maxLength: 100,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 10, 15),
                                  border: InputBorder.none),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: 150,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ILLUSTRATION_BLUE_COLOR_2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              controller: _description,
                              onChanged: (text) {},
                              minLines: 1,
                              maxLines: 5,
                              maxLength: 100,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 0, 10, 15),
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(height: 100)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: _bottomValue,
              left: 0,
              right: 0,
              height: 60,
              duration: new Duration(milliseconds: 300),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 20.0, left: !checkShowAddToQueue() ? 50.0 : 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 150,
                        height: 30,
                        child: FlatButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: ILLUSTRATION_BLUE_COLOR_2,
                            ),
                          ),
                          child: Text(
                            'UPDATE',
                            style: TextStyle(
                              color: ILLUSTRATION_BLUE_COLOR_2,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: this.context,
                                builder: (_) => ConfirmDialog(
                                    "Yes",
                                    "Do you want to update this crack?",
                                    Colors.green,
                                    widget.crack.crackId,
                                    _posDetail.text,
                                    _description.text,
                                    _serverity,
                                    widget.dto,
                                    widget.crack));
                          },
                        ),
                      ),
                      Visibility(
                        visible: checkShowAddToQueue(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 150,
                          height: 30,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(),
                            color: ILLUSTRATION_BLUE_COLOR_2,
                            child: Text(
                              'ADD TO QUEUE',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              List<int> listCrack = new List<int>();
                              listCrack.add(widget.crack.crackId);
                              CrackRepository crackRepo = new CrackRepository();
                              if (listCrack.length > 0) {
                                String result =
                                    await crackRepo.addToQueue(listCrack);
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
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkShowAddToQueue() {
    if (_serverity == CrackSeverity.Low ||
        widget.crack.maintenanceOrderId != -1) return false;
    return true;
  }
}
