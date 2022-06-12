import 'package:bcd_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryBottomButton extends StatelessWidget {
  final Color color;
  final String status;
  HistoryBottomButton(this.color, this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              Icon(
                Icons.qr_code,
                size: 20,
                color: Colors.blue,
              ),
              Text(
                'VRN_0121',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Icon(
                Icons.location_pin,
                size: 20,
                color: Colors.green,
              ),
              Text(
                ' 3m from checkpoint A',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              Icon(
                Icons.report_problem,
                size: 20,
                color: color,
              ),
              Text(
                color == Colors.redAccent
                    ? CrackSeverity.High
                    : color == Colors.orangeAccent
                        ? CrackSeverity.Medium
                        : CrackSeverity.Low,
                style: TextStyle(
                    color: color, fontSize: 12, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: [
              Icon(
                status == CrackStatus.Fixed
                    ? Icons.done
                    : Icons.remove_circle_outline_rounded,
                size: 20,
                color: status == CrackStatus.Fixed
                    ? Colors.green
                    : Colors.blueGrey,
              ),
              Text(
                status,
                style: TextStyle(
                    color: status == CrackStatus.Fixed
                        ? Colors.green
                        : Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 20,
                color: Colors.blueAccent,
              ),
              Text(
                "Evaluation: 7.8/10",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
