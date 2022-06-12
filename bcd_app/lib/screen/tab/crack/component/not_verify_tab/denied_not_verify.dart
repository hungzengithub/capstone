import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:flutter/material.dart';

import '../../crack_screen.dart';
import 'datetimeshow/not_verify_screen_datetime.dart';
import 'datetimeshow/view_image_detail.dart';

// ignore: must_be_immutable
class DeniedNotVerify extends StatelessWidget {
  final UserDTO dto;
  final CrackDTO crack;
  ScrollController _scrollController = ScrollController();
  DeniedNotVerify(this.dto, this.crack);
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
                            "Reject Crack",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "CrackID",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            crack.crackId.toString() ?? "",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Accuracy",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            MyUtil.convertToPercent(crack?.accuracy ?? 0),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) =>
                                    ViewImageDetai(image: crack.image)));
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
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          crack.imageThumbnails)))),
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
                                  CrackRepository crackRepo =
                                      new CrackRepository();
                                  String result = await crackRepo
                                      .deleteCrack(crack.crackId);
                                  if (result != null &&
                                      result.contains("Delete crack success")) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CrackScreen(
                                            dto: dto,
                                            flushBarMessage:
                                                APPMESSAGE.REJECT_CRACK_SUCCESS,
                                            page: 0,
                                          ),
                                        ),
                                        (Route<dynamic> route) =>
                                            route.isFirst);
                                  }
                                },
                                child: Text(
                                  "Reject ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.red[600]),
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
                      backgroundColor: Colors.white,
                      radius: Constants.avatarRadius,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Constants.avatarRadius),
                        ),
                        child: Image.asset("assets/deny.jpg"),
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
