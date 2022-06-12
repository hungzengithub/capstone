import 'package:bcd_app/utils/date_strip/my_calendar_strip.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ScheduledLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScheduledLoadingState();
  }
}

class _ScheduledLoadingState extends State<ScheduledLoading> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 0));
  DateTime endDate = DateTime.now().subtract(Duration(days: 0));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: initScreen(context),
    );
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 12.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.orangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: Colors.teal,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  initScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 100,
            child: MyCalendarStrip(
              startDate: startDate,
              endDate: endDate,
              selectedDate: selectedDate,
              onDateSelected: () {},
              iconColor: DARK_TEXT_COLOR_1,
              containerDecoration: BoxDecoration(color: Colors.white),
              addSwipeGesture: true,
              dateTileBuilder: dateTileBuilder,
              monthNameWidget: _monthNameWidget,
            )),
        Container(
          height: MediaQuery.of(context).size.height - 250,
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return SkeletonAnimation(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300].withOpacity(0.5),
                                spreadRadius: 10,
                                blurRadius: 7,
                                offset:
                                    Offset(1, 10), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SkeletonAnimation(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                child: Container(
                                  margin: EdgeInsets.only(left: 15),
                                  height: 30,
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
                                  margin: EdgeInsets.only(right: 15),
                                  height: 20,
                                  width: 20,
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
                        )));
              }),
        )
      ],
    );
  }
}
