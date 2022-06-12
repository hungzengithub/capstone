import 'package:bcd_app/objects/workerDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkerBox extends StatefulWidget {
  final WorkerDTO worker;
  WorkerDTO currentWorker;
  WorkerBox(this.worker, this.currentWorker);
  @override
  State<StatefulWidget> createState() {
    return bottomSheetWorkerState();
  }
}

// ignore: camel_case_types
class bottomSheetWorkerState extends State<WorkerBox> {
  double animatedHeight = 50;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: animatedHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: 130,
                            child: Row(
                              children: [
                                Container(
                                  width: 75,
                                  child: FlatButton(
                                      child: Text("Select",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      onPressed: () {
                                        setState(() {
                                          widget.currentWorker = widget.worker;
                                          Navigator.of(context).pop();
                                        });
                                      }),
                                ),
                                Container(
                                  width: 40,
                                  child: FlatButton(
                                      child: Icon(Icons.arrow_drop_down),
                                      onPressed: () {
                                        setState(() {
                                          if (animatedHeight == 50) {
                                            animatedHeight = 120;
                                          } else
                                            animatedHeight = 50;
                                        });
                                      }),
                                ),
                              ],
                            )))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://i.chungta.vn/2017/12/25/LogoFPT-2017-copy-3042-1513928-4697-9171-1514166704.jpg"),
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(width: 10),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child:
                                    Row(children: [Text(widget.worker.name)])),
                          ],
                        ))
                  ],
                ),
              ],
            ),
            Visibility(
                visible: animatedHeight == 50 ? false : true,
                child: Container(
                    child: Row(children: [
                  SizedBox(width: 10),
                  Icon(Icons.phone_enabled, size: 18, color: Colors.grey[400]),
                  SizedBox(width: 10),
                  Text(widget.worker.phone,
                      style: TextStyle(
                        color: Colors.grey[500],
                      )),
                ]))),
            Visibility(
                visible: animatedHeight == 50 ? false : true,
                child: Container(
                    child: Row(children: [
                  SizedBox(width: 10),
                  Icon(Icons.house_sharp, size: 18, color: Colors.grey[400]),
                  SizedBox(width: 10),
                  Text(widget.worker.address,
                      style: TextStyle(
                        color: Colors.grey[500],
                      )),
                ]))),
            Visibility(
                visible: animatedHeight == 50 ? false : true,
                child: Container(
                    child: Row(children: [
                  SizedBox(width: 10),
                  Icon(Icons.email, size: 18, color: Colors.grey[400]),
                  SizedBox(width: 10),
                  Text(widget.worker.email,
                      style: TextStyle(
                        color: Colors.grey[500],
                      )),
                ]))),
          ],
        ));
  }
}
