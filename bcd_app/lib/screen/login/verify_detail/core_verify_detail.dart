import 'package:flutter/material.dart';

class CoreVerifyDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Card(
        shadowColor: Colors.pink,
        child: Padding(
          padding: const EdgeInsets.all(0),
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
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height/13,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Severity",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Position",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                  ),
                )),
            Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Status",
                    labelStyle: TextStyle(fontSize: 15, color: Colors.pink),
                  ),
                )),
          ],
        ),
      ),
    ]);
  }
}
