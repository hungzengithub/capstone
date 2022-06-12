import 'package:bcd_app/screen/login/verify_detail/scheduled_verify_detail.dart';
import 'package:flutter/material.dart';

class WithoutScheduleVerifyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //    resizeToAvoidBottomPadding: false,
      body: Column(children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.only(),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image(
                        height: 80,
                        image: AssetImage('assets/test.jpg'),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Text('ID'),
                              Container(
                                height: 15,
                                width: 0,
                              ),
                              Text('Day'),
                            ],
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Severity",
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Position",
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Description",
                    ),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Status",
                    ),
                  )),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 12,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduledVerifyDetail()));
                    },
                    color: Colors.white,
                    child: Text("Add"),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 12,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {},
                    color: Colors.white,
                    child: Text("Update"),
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
