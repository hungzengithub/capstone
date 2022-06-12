import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/date_strip/my_calendar_strip.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'history_list.dart';

// ignore: must_be_immutable
class HistoryDateTimeScroll extends StatefulWidget {
  DateTime selectedDate;
  UserDTO dto;
  HistoryDateTimeScroll(DateTime selectedDate, this.dto, this.listMaintain);
  final List<MaintainanceDTO> listMaintain;
  @override
  _HistoryDateTimeScrollState createState() => _HistoryDateTimeScrollState();
}

class _HistoryDateTimeScrollState extends State<HistoryDateTimeScroll> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 300));
  DateTime endDate = DateTime.now().add(Duration(days: 300));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  HistoryList widgetMaintain = new HistoryList(DateTime.now(), null);

  List<DateTime> markedDates = [];

  @override
  void initState() {
    super.initState();
    widgetMaintain = new HistoryList(DateTime.now(), widget.dto);
    selectedDate = widget.selectedDate;
    for (MaintainanceDTO dto in widget.listMaintain) {
      DateTime tempDate =
          new DateFormat("yyyy-MM-dd").parse(dto.maintenanceDate);
      markedDates.add(tempDate);
    }
    if (widget.listMaintain.length > 0) {
      DateTime tempDate = new DateFormat("yyyy-MM-dd")
          .parse(widget.listMaintain.first.maintenanceDate);
      widgetMaintain = new HistoryList(tempDate, widget.dto);
      for (MaintainanceDTO dto in widget.listMaintain) {
        tempDate = new DateFormat("yyyy-MM-dd").parse(dto.maintenanceDate);
        markedDates.add(tempDate);
      }
      if (markedDates != null) {
        selectedDate = markedDates.last;
        endDate = markedDates.first;
        startDate = markedDates.last;
      }
    }
  }

  onSelect(data) {
    setState(() {
      selectedDate = data;
      widget.selectedDate = data;
      widgetMaintain = new HistoryList(selectedDate, widget.dto);
    });
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    var pos = monthName.lastIndexOf(' ');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            monthName.substring(0, pos) + " ",
            style: TextStyle(
              fontSize: 35,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(
              monthName.split(" ").last,
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle = TextStyle(fontSize: 16, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, color: Colors.blue, fontWeight: FontWeight.w500);
    TextStyle selectedDayNameStyle = TextStyle(
        fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w400);
    TextStyle dayNameStyle = TextStyle(fontSize: 12.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName,
          style: !isSelectedDate ? dayNameStyle : selectedDayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, bottom: 5),
      decoration: BoxDecoration(
        color:
            !isSelectedDate ? Colors.transparent : Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(height: 40),
        Container(
            child: MyCalendarStrip(
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          onDateSelected: onSelect,
          onWeekSelected: onWeekSelect,
          dateTileBuilder: dateTileBuilder,
          iconColor: DARK_TEXT_COLOR_1,
          monthNameWidget: _monthNameWidget,
          markedDates: markedDates,
          containerDecoration: BoxDecoration(color: Colors.white),
          addSwipeGesture: true,
        )),
        widgetMaintain
      ],
    ));
  }
}
