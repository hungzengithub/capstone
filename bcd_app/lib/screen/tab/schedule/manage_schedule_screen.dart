import 'dart:async';

import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/notification_dialog.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'history_tab/history_screen.dart';
import 'queue_tab/queue_screen.dart';
import 'repair_record_tab/scheduled_screen.dart';
import 'unscheduled_tab/unscheduled_screen.dart';

class ScheduleScreen extends StatefulWidget {
  final int selectedTab;
  final UserDTO dto;
  final String flushBarMessage;

  const ScheduleScreen(
      {Key key, this.dto, this.selectedTab, this.flushBarMessage})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ScheduleScreenState();
  }
}

class ScheduleScreenState extends State<ScheduleScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  bool isAdd = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentIndex = widget.selectedTab;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.flushBarMessage != null) {
        Flushbar(
          message: widget.flushBarMessage,
          duration: Duration(seconds: 1),
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
              Timer(Duration(seconds: 2), () {
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

  @override
  Widget build(BuildContext context) {
    final tabs = [
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [UnScheduledScreen(widget.dto, isAdd)],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [QueueScreen(widget.dto, isAdd)],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [ScheduledScreen(widget.dto, isAdd)],
          ),
        ),
      ),
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: [HistoryScreen(widget.dto)],
          ),
        ),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
      //   title: Text(
      //     'REPAIR RECORD',
      //     style: TextStyle(
      //       fontSize: 16,
      //       color: Color.fromRGBO(32, 49, 82, 1),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     _currentIndex != 2
      //         ? IconButton(
      //             icon: Icon(Icons.library_add),
      //             onPressed: () {
      //               setState(() {
      //                 isAdd == true ? isAdd = false : isAdd = true;
      //               });
      //             })
      //         : Text("")
      //   ],
      // ),
      key: scaffoldKey,
      drawer: MainDrawer(dto: widget.dto, selectedTab: 4),
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
                            title: Text("Unrecorded",
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
                            title: Text("Queue",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white))),
                        BubbleBottomBarItem(
                            backgroundColor: BOTTOM_NAV_COLOR,
                            icon: Icon(
                              Icons.pending_actions_rounded,
                              size: 18,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(Icons.pending_actions_rounded,
                                size: 14, color: Colors.white),
                            title: Text("Repair",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white))),
                        BubbleBottomBarItem(
                            backgroundColor: BOTTOM_NAV_COLOR,
                            icon: Icon(
                              Icons.history_rounded,
                              size: 18,
                              color: Colors.grey,
                            ),
                            activeIcon: Icon(Icons.not_interested,
                                size: 14, color: Colors.white),
                            title: Text("History",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white)))
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
                            child: Text("MANAGE REPAIR",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500))),
                        Icon(Icons.notes_sharp, color: Colors.grey[100]),
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
}
