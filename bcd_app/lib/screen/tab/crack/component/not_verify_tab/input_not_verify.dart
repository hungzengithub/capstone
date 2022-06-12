import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/not_verify_screen_datetime.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../crack_screen.dart';

class InputNotVerify extends StatefulWidget {
  final UserDTO dto;
  final CrackDTO crack;

  InputNotVerify(this.crack, this.dto);
  @override
  State<StatefulWidget> createState() {
    return InputNotVerifyState();
  }
}

// ignore: must_be_immutable
class InputNotVerifyState extends State<InputNotVerify> {
  String _serverity;
  TextEditingController _posDetail = new TextEditingController(text: "");
  TextEditingController _description = new TextEditingController(text: "");
  bool _validate = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _serverity = widget.crack.severity == null || widget.crack.severity == ''
        ? CrackSeverity.Medium
        : widget.crack.severity;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: Constants.padding,
                        top: Constants.avatarRadius + Constants.padding,
                        right: Constants.padding,
                        bottom: Constants.padding),
                    margin: EdgeInsets.only(top: Constants.avatarRadius),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Constants.padding),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Confirm Crack",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "CrackID",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "18",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Accuracy",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            MyUtil.convertToPercent(
                                widget.crack?.accuracy ?? 0),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Severity",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                                value: _serverity,
                                onChanged: (newValue) {
                                  setState(() {
                                    _serverity = newValue;
                                  });
                                },
                                items: ["High", "Medium", "Low"].map((value) {
                                  return DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
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
                          height: 5,
                        ),
                        Text(
                          "Position detail",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            controller: _posDetail,
                            onChanged: (text) {},
                            minLines: 1,
                            maxLines: 5,
                            maxLength: 50,
                            maxLengthEnforced: true,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.black),
                            onTap: () {
                              setState(() {
                                _validate = true;
                              });
                            },
                            decoration: InputDecoration(
                                errorText: !_validate
                                    ? 'Position detail is a required field'
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Description (optional)",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: TextFormField(
                            controller: _description,
                            onChanged: (text) {},
                            minLines: 1,
                            maxLines: 5,
                            maxLength: 100,
                            maxLengthEnforced: true,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 0, 10, 15),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  setState(() {
                                    _posDetail.text.isEmpty
                                        ? _validate = false
                                        : _validate = true;
                                  });
                                  if (_validate) {
                                    CrackRepository crackRepo =
                                        new CrackRepository();
                                    String result =
                                        await crackRepo.updateNotVerifyCrack(
                                            widget.crack.crackId,
                                            _description.value.text,
                                            _serverity,
                                            CrackStatus
                                                .UnscheduledForMaintenace,
                                            _posDetail.value.text);
                                    if (result != null &&
                                        result
                                            .contains("Update crack success")) {
                                      if (_serverity == CrackSeverity.High) {
                                        List<int> listCrack = new List<int>();
                                        listCrack.add(widget.crack.crackId);
                                        CrackRepository crackRepo =
                                            new CrackRepository();
                                        await crackRepo.addToQueue(listCrack);
                                      }
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CrackScreen(
                                              dto: widget.dto,
                                              flushBarMessage: APPMESSAGE
                                                  .CONFIRM_CRACK_SUCCESS,
                                              page: 0,
                                            ),
                                          ),
                                          (Route<dynamic> route) =>
                                              route.isFirst);
                                    } else {
                                      Flushbar(
                                        message: APPMESSAGE.CONFIRM_CRACK_FAIL,
                                        duration: Duration(seconds: 1),
                                      )..show(context);
                                    }
                                  }
                                },
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.green[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: Constants.padding,
                    right: Constants.padding,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: Constants.avatarRadius,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Constants.avatarRadius),
                        ),
                        child: Image.asset("assets/verify.jpg"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
