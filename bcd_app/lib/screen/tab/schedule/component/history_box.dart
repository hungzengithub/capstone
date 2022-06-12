import 'package:bcd_app/screen/tab/schedule/component/left_of_history_box.dart';
import 'package:flutter/material.dart';

class HistoryBox extends StatelessWidget {
  final Color color;
  final String status;
  HistoryBox(this.color, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [LeftOfHistoryBox(color, status)],
        ));
  }
}
