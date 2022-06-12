import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryDetails extends StatefulWidget {
  final String title;
  final Color color;
  HistoryDetails(this.title, this.color);
  @override
  State<StatefulWidget> createState() {
    return HistoryDetailsState();
  }
}

class HistoryDetailsState extends State<HistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: DEFAULT_COLOR,
            title: Text(
              "Crack Details",
              style: TextStyle(color: Colors.white),
            )),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: new Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  child: AnimatedContainer(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 800,
                      duration: const Duration(milliseconds: 120),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(1, 10), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //         colors: [HexColor("#ffffff"),Color.fromRGBO(37, 49, 61, 1)]
                        // )
                      ),
                      child: Column(
                        children: [
                          // CrackDetailTitle(widget.title),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    width: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.qr_code,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              Text(
                                                " VRN_001",
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_pin,
                                                size: 20,
                                                color: Colors.green,
                                              ),
                                              Text(" 3m from checkpoint 1",
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                size: 20,
                                                color: Colors.deepOrange,
                                              ),
                                              Text(" 12/12/2020 11:00",
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.report_problem,
                                                size: 20,
                                                color: widget.color,
                                              ),
                                              Text(
                                                  widget.color ==
                                                          Colors.redAccent
                                                      ? CrackSeverity.High
                                                      : widget.color ==
                                                              Colors
                                                                  .orangeAccent
                                                          ? CrackSeverity.Medium
                                                          : CrackSeverity.Low,
                                                  style:
                                                      TextStyle(fontSize: 16))
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          controller: TextEditingController(
                                              text: "12/01/2021"),
                                          style:
                                              TextStyle(color: Colors.black54),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              labelText: 'Repair time',
                                              //prefixIcon: Icon(Icons.email),
                                              icon:
                                                  Icon(Icons.av_timer_rounded)),
                                        ),
                                        TextFormField(
                                          controller: TextEditingController(
                                              text: "...."),
                                          style:
                                              TextStyle(color: Colors.black54),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              labelText: 'Position Detail',
                                              //prefixIcon: Icon(Icons.email),
                                              icon:
                                                  Icon(Icons.av_timer_rounded)),
                                        ),
                                      ],
                                    )),
                                Opacity(
                                  opacity: 0.501960813999176,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                        color: ILLUSTRATION_GREY_HIGH_COLOR,
                                        width: 0.5,
                                      ))),
                                ),
                                new AnimatedContainer(
                                  margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(241, 241, 241, 1),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 5,
                                    //     blurRadius: 7,
                                    //     offset: Offset(1, 10), // changes position of shadow
                                    //   ),
                                    // ],
                                    //     gradient: LinearGradient(
                                    //       begin: Alignment.topLeft,
                                    //       end: Alignment.bottomRight,
                                    //         colors: [HexColor("#ffffff"),Color.fromRGBO(37, 49, 61, 1)]
                                    // )
                                  ),
                                  duration: const Duration(milliseconds: 120),
                                  child: SingleChildScrollView(
                                    child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: TextEditingController(
                                                  text: "FPT Repairer"),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  labelText: 'Repairer',
                                                  hintText: "FPT Repair",
                                                  //prefixIcon: Icon(Icons.email),
                                                  icon: Icon(
                                                      Icons.perm_identity)),
                                            ),
                                            TextFormField(
                                              controller: TextEditingController(
                                                  text: "12/01/2021"),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  labelText: 'Repair time',
                                                  //prefixIcon: Icon(Icons.email),
                                                  icon: Icon(
                                                      Icons.av_timer_rounded)),
                                            ),
                                            TextFormField(
                                              controller: TextEditingController(
                                                  text:
                                                      "Repair by FPT repairer..."),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Repair description',
                                                  //prefixIcon: Icon(Icons.email),
                                                  icon: Icon(
                                                      Icons.av_timer_rounded)),
                                            ),
                                            Opacity(
                                              opacity: 0.501960813999176,
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 1,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                    color:
                                                        ILLUSTRATION_GREY_HIGH_COLOR,
                                                    width: 0.5,
                                                  ))),
                                            ),
                                            TextFormField(
                                              controller: TextEditingController(
                                                  text: "7.8/10"),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Evaluation result:',
                                                  //prefixIcon: Icon(Icons.email),
                                                  icon: Icon(Icons
                                                      .rate_review_outlined)),
                                            ),
                                            TextFormField(
                                              controller: TextEditingController(
                                                  text: "..."),
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  labelText:
                                                      'Evaluation detail:',
                                                  //prefixIcon: Icon(Icons.email),
                                                  icon:
                                                      Icon(Icons.description)),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              width: double.infinity,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.yellow,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  height: 400,
                                  width: double.infinity,
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
