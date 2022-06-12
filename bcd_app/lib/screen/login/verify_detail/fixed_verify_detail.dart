import 'package:flutter/material.dart';

import 'core_verify_detail.dart';

class FixedVerifyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Assesment Result",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                ),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Feedback",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                ),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Complete Time",
                  labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                ),
              )),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 70, right: 70),
              height: MediaQuery.of(context).size.height / 13,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () {},
                color: Colors.white,
                child: Text("View History"),
              )),
        ],
      ),
    );
  }
}
