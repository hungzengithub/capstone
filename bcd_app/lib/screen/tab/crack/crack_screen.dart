import 'dart:async';

import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/notification_dialog.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'component/filter_crack.dart';
import 'component/not_verify_tab/datetimeshow/not_verify_scheduled_screen.dart';
import 'component/verify_tab/datetimeshow/verify_scheduled_screen.dart';

class CrackScreen extends StatefulWidget {
  final UserDTO dto;
  final String flushBarMessage;
  final int page;
  const CrackScreen({Key key, this.dto, this.flushBarMessage, this.page})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CrackScreenState();
  }
}

typedef void StringCallback(String val);

class CrackScreenState extends State<CrackScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  int filterValue = 0;
  VerifyCrackDatetimeScreen verifyDatetime;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _status = "All";

  callback(String value) {
    setState(() {
      _status = value;
      if (_status == "All") {
        filterValue = 0;
      } else if (_status == CrackStatus.UnscheduledForMaintenace) {
        filterValue = 1;
      } else if (_status == CrackStatus.ScheduledForMaintenace) {
        filterValue = 2;
      } else if (_status == CrackStatus.Fixed) {
        filterValue = 3;
      }
      print(_status ?? "All");
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndex = widget.page;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.flushBarMessage != null) {
        Flushbar(
          message: widget.flushBarMessage,
          duration: Duration(seconds: 2),
        )..show(context);
      }
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //  print(message['notification']);
        print(message['notification']['title']);
        showDialog(
            context: context,
            builder: (BuildContext builderContext) {
              Timer(Duration(seconds: 20), () {
                Navigator.of(context).pop();
              });
              return NotificationDialog(
                  title: message['notification']['title'],
                  message: message['notification']['body']);
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final tabs = [
      NotVerifyCrackDatetimeScreen(
        widget.dto,
      ),
      VerifyCrackDatetimeScreen(widget.dto, filterValue),
    ];
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer: MainDrawer(
        dto: widget.dto,
        selectedTab: 3,
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[tabs[_currentIndex]],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(height: 10, color: Colors.grey[100]),
                  SizedBox(
                    height: 40,
                    width: 300,
                    child: BubbleBottomBar(
                      opacity: .8,
                      currentIndex: _currentIndex,
                      onTap: (int index) {
                        setState(() => _currentIndex = index);
                      },
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      elevation: 0,
                      inkColor: Colors.black12,
                      iconSize: 22,
                      backgroundColor: Colors.grey[100],
                      items: <BubbleBottomBarItem>[
                        BubbleBottomBarItem(
                            backgroundColor: BOTTOM_NAV_COLOR,
                            icon: Icon(
                              Icons.cancel_schedule_send,
                              size: 18,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(Icons.cancel_schedule_send,
                                size: 12, color: Colors.white),
                            title: Text("NOT VERIFY",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white))),
                        BubbleBottomBarItem(
                            backgroundColor: BOTTOM_NAV_COLOR,
                            icon: Icon(
                              Icons.shopping_basket_outlined,
                              size: 18,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(Icons.shopping_basket_outlined,
                                size: 14, color: Colors.white),
                            title: Text("VERIFY",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white))),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child:
                                  Icon(Icons.notes_sharp, color: Colors.grey),
                            ),
                            onTap: () {
                              scaffoldKey.currentState.openDrawer();
                            }),
                        Center(
                            child: Text("CRACK SCREEN",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500))),
                        _currentIndex == 1
                            ? GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.filter_alt_outlined,
                                      color: Colors.grey),
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) {
                                        return FilterCrack(
                                            filterValue: _status,
                                            callBack: callback);
                                      });
                                })
                            : SizedBox(width: 35),
                      ],
                    ),
                    color: Colors.grey[100],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
