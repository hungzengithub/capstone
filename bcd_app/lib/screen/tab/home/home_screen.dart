import 'dart:async';

import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  final UserDTO dto;
  const HomeScreen({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //  print(message['notification']);
        print(message['notification']['title']);
        showDialog(
            context: context,
            builder: (BuildContext builderContext) {
              Timer(Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(message['notification']['title']),
                content: SingleChildScrollView(
                  child: Text(message['notification']['body'],
                      style: TextStyle(color: Colors.black)),
                ),
              );
            });

        return;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        return;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("matchscore");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
          title: Text(
            'HOME',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(32, 49, 82, 1),
            ),
          ),
          actions: [],
        ),
        drawer: MainDrawer(
          dto: widget.dto,
          selectedTab: 1,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140,
                    color: DEFAULT_COLOR,
                  )
                ],
              ),
            ),

            // Total Doc
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Good morning, ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              widget.dto.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                    Container(
                      width: 260,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Total cracks",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "100",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Opacity(
                            opacity: 0.501960813999176,
                            child: Container(
                                width: 250,
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: ILLUSTRATION_GREY_HIGH_COLOR,
                                  width: 0.5,
                                ))),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      CrackStatus.UnscheduledForMaintenace,
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "29",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      CrackStatus.ScheduledForMaintenace,
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "32",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.orangeAccent,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      CrackStatus.Fixed,
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "19",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Not verify",
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                )),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "20",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.deepOrange, // button color
                                    child: InkWell(
                                      splashColor: Colors.red, // inkwell color
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: Icon(
                                            LineIcons.play,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Input video",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.green, // button color
                                    child: InkWell(
                                      splashColor: Colors.red, // inkwell color
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: Icon(
                                            LineIcons.video_camera,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Scan now",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //OpacityLine(),
                  ],
                )),
          ],
        ));
  }
}
