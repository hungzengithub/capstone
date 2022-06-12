import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../manage_schedule_screen.dart';

class RemoveQueueItem extends StatefulWidget {
  final List<CrackDTO> listCrack;
  final UserDTO dto;

  const RemoveQueueItem({Key key, this.listCrack, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return RemoveQueueItemState();
  }
}

// ignore: camel_case_types
class RemoveQueueItemState extends State<RemoveQueueItem> {
  bool isAdd = false;
  List<int> listRemove = new List<int>();
  callbackSelect(int value) {
    setState(() {
      setState(() {
        listRemove.add(value);
      });
    });
  }

  callbackUnselect(int value) {
    setState(() {
      setState(() {
        listRemove.remove(value);
      });
    });
  }

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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          child: Text("Cancel",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16)))),
                  GestureDetector(
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
                                    builder: (context) => ScheduleScreen(
                                          dto: widget.dto,
                                          selectedTab: 1,
                                          flushBarMessage: APPMESSAGE
                                              .REMOVE_FROM_QUEUE_SUCCESS,
                                        )),
                                (Route<dynamic> route) => route.isFirst);
                          } else {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScheduleScreen(
                                          dto: widget.dto,
                                          selectedTab: 1,
                                          flushBarMessage:
                                              APPMESSAGE.REMOVE_FROM_QUEUE_FAIL,
                                        )),
                                (Route<dynamic> route) => route.isFirst);
                          }
                        }
                      },
                      child: Container(
                          child: Text("Remove",
                              style: TextStyle(
                                  color: listRemove.length > 0
                                      ? Colors.black
                                      : Colors.grey[500],
                                  fontSize: 16)))),
                ],
              ),
            ),
            Container(
              height: 220,
              child: ListView.builder(
                  itemCount: widget.listCrack.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return CrackCheckBox(widget.listCrack[index],
                        callbackSelect, callbackUnselect);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CrackCheckBox extends StatefulWidget {
  final CrackDTO crack;
  final Function(int) callbackSelect;
  final Function(int) callbackUnSelect;

  const CrackCheckBox(this.crack, this.callbackSelect, this.callbackUnSelect);
  @override
  State<StatefulWidget> createState() {
    return CrackCheckBoxState();
  }
}

// ignore: camel_case_types
class CrackCheckBoxState extends State<CrackCheckBox> {
  bool _checkBox = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _checkBox,
      onChanged: (bool selected) {
        setState(() {
          _checkBox = selected;
          if (_checkBox) {
            widget.callbackSelect(widget.crack.crackId);
          } else
            widget.callbackUnSelect(widget.crack.crackId);
        });
      },
      title: Text("Crack " + widget.crack.crackId.toString(),
          style: TextStyle(color: Colors.black)),
    );
  }
}
