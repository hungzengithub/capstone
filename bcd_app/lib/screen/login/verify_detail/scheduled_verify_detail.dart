import 'package:flutter/material.dart';

import 'core_verify_detail.dart';
import 'fixed_verify_detail.dart';

class ScheduledVerifyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          CoreVerifyDetail(),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Repairer",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                ),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Repair Time",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                ),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 70, right: 70),
              height: MediaQuery.of(context).size.height / 12,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FixedVerifyDetail()));
                },
                color: Colors.white,
                child: Text("View Schedule Detail"),
              )),
        ],
      ),
    );
  }
}
