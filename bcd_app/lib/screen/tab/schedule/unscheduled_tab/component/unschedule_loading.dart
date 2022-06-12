import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class UnScheduleLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UnScheduleLoadingState();
  }
}

class _UnScheduleLoadingState extends State<UnScheduleLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SkeletonAnimation(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
            height: 20,
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
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5)),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 240,
          child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return SkeletonAnimation(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300].withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(1, 10), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(
                          children: [
                            SkeletonAnimation(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SkeletonAnimation(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, top: 20),
                                      height: 20,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, top: 10),
                                      height: 20,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                ),
                                SkeletonAnimation(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 15, top: 10),
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                          ],
                        )));
              }),
        )
      ],
    );
  }
}
