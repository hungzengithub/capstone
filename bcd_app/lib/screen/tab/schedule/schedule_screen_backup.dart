import 'package:bcd_app/screen/tab/schedule/component/history_box.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen();
  @override
  State<StatefulWidget> createState() {
    return _ScheduleScreenState();
  }
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(height: 60),
              child: TabBar(
                  tabs: [
                    Tab(text: "Cart"),
                    Tab(text: "Schedule"),
                    Tab(text: "History"),
                  ],
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: 40,
                    indicatorColor: Colors.lightBlueAccent,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  )),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    height: 600,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: <Widget>[
                                    // CrackNotVerifyBox( "xx"),
                                    // CrackNotVerifyBox("xx"),
                                    // CrackNotVerifyBox("xx"),
                                    // CrackNotVerifyBox( "xx"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25,
                              child: IconButton(
                                iconSize: 30,
                                padding: EdgeInsets.zero,
                                icon: Icon(LineIcons.plus),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          flex: 2,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        HistoryBox(Colors.redAccent, "Repaired"),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
