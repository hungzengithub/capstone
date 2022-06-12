import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/flutter_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Input_not_verify.dart';
import '../denied_not_verify.dart';

class CrackNotVerifyListDateTime extends StatefulWidget {
  final UserDTO dto;
  final List<CrackDTO> listCrack;

  CrackNotVerifyListDateTime(this.dto, this.listCrack);
  @override
  State<StatefulWidget> createState() {
    return _CrackNotVerifyListDateTimeState();
  }
}

class _CrackNotVerifyListDateTimeState
    extends State<CrackNotVerifyListDateTime> {
  @override
  Widget build(BuildContext context) {
    return widget.listCrack.length > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.listCrack != null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 2,
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      height: MediaQuery.of(context).size.height - 230,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0.0),
                            itemCount: widget.listCrack.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return NotVerifyBox(
                                  widget.listCrack[index], widget.dto);
                            }),
                      ),
                    )
                  : Container(child: Text("No scan for today")),
            ],
          )
        : Container(
            child: Text("No cracks for this day"),
          );
  }
}

class NotVerifyBox extends StatelessWidget {
  final CrackDTO crack;
  final UserDTO dto;
  NotVerifyBox(this.crack, this.dto);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200].withOpacity(1),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
              color: Colors.white,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => ViewImageDetai(image: crack.image)));
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
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(crack.imageThumbnails)))),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                              "Crack " + crack.crackId.toString() ?? "N/A",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.location_searching,
                                color: ILLUSTRATION_PINK_COLOR, size: 18),
                            SizedBox(width: 10),
                            Text(
                              "Accuracy",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40),
                            Text(
                              MyUtil.convertToPercent(crack?.accuracy ?? 0),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 25),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Constants.padding),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: DeniedNotVerify(
                                          dto,
                                          crack,
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                "Reject",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Constants.padding),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: InputNotVerify(
                                          crack,
                                          dto,
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.green[800], fontSize: 13),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
