import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/screen/tab/schedule/queue_screen.dart';
import 'package:bcd_app/screen/tab/schedule/unscheduled_screen.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';

import 'component/history_box.dart';

class ScheduleScreen extends StatefulWidget {
  final UserDTO dto;

  const ScheduleScreen({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ScheduleScreenState();
  }
}

class ScheduleScreenState extends State<ScheduleScreen> {
  int _currentIndex = 0;
  PageController _pageController;
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DEFAULT_COLOR,
          title: Text(
            'Schedule',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            _currentIndex != 2
                ? IconButton(
                    icon: Icon(Icons.library_add),
                    onPressed: () {
                      setState(() {
                        isAdd == true ? isAdd = false : isAdd = true;
                      });
                    })
                : Text("")
          ],
        ),
        drawer: MainDrawer(dto: widget.dto),
        body: SizedBox.expand(
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              _currentIndex == 0
                  ? UnScheduledScreen(widget.dto, isAdd)
                  : _currentIndex == 1
                      ? QueueScreen(widget.dto, isAdd)
                      : SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                HistoryBox(Colors.yellow, "Fixed"),
                                HistoryBox(Colors.redAccent, "Removed"),
                              ],
                            ),
                          ),
                        ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: DEFAULT_COLOR,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          selectedFontSize: 14,
          unselectedFontSize: 12,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm_off_rounded),
              title: Text(
                "UnScheduled",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.calendar_today_rounded),
              title: Text(
                "Scheduled",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.green,
              icon: Icon(Icons.history),
              title: Text(
                "History",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ));
  }
}
