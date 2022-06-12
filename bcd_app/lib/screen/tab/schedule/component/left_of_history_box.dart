import 'package:bcd_app/screen/tab/schedule/component/history_button_bottom.dart';
import 'package:flutter/material.dart';

import 'history_detail.dart';

class LeftOfHistoryBox extends StatelessWidget {
  final Color color;
  final String status;
  LeftOfHistoryBox(this.color, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.only(left: 10),
      height: 160,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 10), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [HexColor("#ffffff"),color]
        // )
      ),
      child: Row(
        children: [
          Container(
              height: double.infinity,
              width: 10,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)))),
          //LeftCrackBoxImage(),
          HistoryBottomButton(color, status),
          Container(
              margin: EdgeInsets.only(left: 10),
              child: IconButton(
                icon: Icon(
                  Icons.double_arrow_rounded,
                  size: 30,
                  color: Colors.black12,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryDetails(status, color)),
                  );
                },
              ))
        ],
      ),
    );
  }
}
