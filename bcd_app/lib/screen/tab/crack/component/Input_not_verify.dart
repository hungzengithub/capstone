import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:flutter/material.dart';

import '../crack_screen.dart';

class InputNotVerify extends StatefulWidget {
  final UserDTO dto;
  final CrackDTO crack;
  InputNotVerify(this.crack, this.dto);
  @override
  State<StatefulWidget> createState() {
    return InputNotVerifyState();
  }
}

// ignore: must_be_immutable
class InputNotVerifyState extends State<InputNotVerify> {
  List<String> _serveritys = <String>['Low', 'Medium', 'High'];
  String _serverity = 'Low';
  TextEditingController severity = new TextEditingController(text: "");
  TextEditingController description = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.green,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          "Verify crack",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Montserrat",
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.qr_code,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      "ID: " + widget.crack.crackId.toString(),
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 20,
                                      color: Colors.green,
                                    ),
                                    Text(widget.crack.position,
                                        style: TextStyle(fontSize: 16))
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: Colors.deepOrange,
                                    ),
                                    Text(widget.crack.created,
                                        style: TextStyle(fontSize: 16))
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: description,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(color: Colors.black54),
                                decoration: InputDecoration(
                                    fillColor: Colors.red,
                                    labelText: 'Description',
                                    icon: Icon(Icons.perm_identity)),
                              ),
                              FormField(
                                builder: (FormFieldState state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      icon: const Icon(Icons.report_problem),
                                    ),
                                    isEmpty: _serverity == 'Low',
                                    child: new DropdownButtonHideUnderline(
                                      child: new DropdownButton(
                                        value: _serverity,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _serverity = newValue;
                                          });
                                        },
                                        items: _serveritys.map((String value) {
                                          return new DropdownMenuItem(
                                            value: value,
                                            child: new Text(value,
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: FlatButton(
                                        color: Colors.red,
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () async {
                                          CrackRepository crackRepo =
                                              new CrackRepository();
                                          String result = await crackRepo
                                              .updateNotVerifyCrack(
                                                  widget.crack.crackId,
                                                  description.value.text,
                                                  _serverity,
                                                  "Unscheduled for maintenace");
                                          if (result != null &&
                                              result.contains(
                                                  "Update crack success")) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CrackScreen(
                                                          dto: widget.dto)),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: FlatButton(
                                        color: Colors.blueGrey,
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
