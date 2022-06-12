import 'package:bcd_app/objects/crackDTO.dart';
import 'package:flutter/material.dart';

class VerifyButtonBottom extends StatelessWidget {
  final CrackDTO crack;
  VerifyButtonBottom(this.crack);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 20,
                    color: Colors.blue,
                  ),
                  Text(
                    'ID: ' + crack.crackId.toString(),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
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
                        fontFamily: 'Montserrat',
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
                    color: crack.severity == "Low"
                        ? Colors.yellowAccent
                        : crack.severity == "Medium"
                            ? Colors.orangeAccent
                            : Colors.redAccent,
                  ),
                  Text(
                    crack.severity,
                    style: TextStyle(
                        color: crack.severity == "Low"
                            ? Colors.yellowAccent
                            : crack.severity == "Medium"
                                ? Colors.orangeAccent
                                : Colors.redAccent,
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    crack.status == "Fixed"
                        ? Icons.done
                        : crack.status == "Scheduled for maintenace"
                            ? Icons.hardware
                            : Icons.close_outlined,
                    size: 20,
                    color: crack.status == "Fixed"
                        ? Colors.green
                        : crack.status == "Scheduled for maintenace"
                            ? Colors.blueAccent
                            : Colors.blueGrey,
                  ),
                  Text(
                    crack.status.split(" ").first,
                    style: TextStyle(
                        color: crack.status == "Fixed"
                            ? Colors.green
                            : crack.status == "Scheduled for maintenace"
                                ? Colors.blueAccent
                                : Colors.blueGrey,
                        fontFamily: 'Montserrat',
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
