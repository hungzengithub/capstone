import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_detail_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../crack_screen.dart';

class CrackDetail2 extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  CrackDetail2({@required this.crack, @required this.dto});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<CrackDetail2> {
  double _animatedHeight = 0.0;
  double _animatedBigHeight = 350;
  List<String> _serveritys = <String>['Low', 'Medium', 'High'];
  String _serverity = 'Low';
  TextEditingController severity = new TextEditingController(text: "");
  TextEditingController description = new TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    setState(() {
      _serverity = widget.crack.severity;
      description = new TextEditingController(text: widget.crack.description);
      print("xx");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.crack.image,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 250,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID: " + widget.crack.crackId.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    widget.crack.position,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    widget.crack.created,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Card(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new GestureDetector(
                        child: AnimatedContainer(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: MediaQuery.of(context).size.width,
                            height: _animatedBigHeight,
                            duration: const Duration(milliseconds: 120),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      1, 10), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              //     gradient: LinearGradient(
                              //       begin: Alignment.topLeft,
                              //       end: Alignment.bottomRight,
                              //         colors: [HexColor("#ffffff"),Color.fromRGBO(37, 49, 61, 1)]
                              // )
                            ),
                            child: Column(
                              children: [
                                CrackDetailTitle("Crack Details"),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: 300,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextFormField(
                                                controller: description,
                                                keyboardType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                                decoration: InputDecoration(
                                                    fillColor: Colors.red,
                                                    labelText:
                                                        'Position description',
                                                    icon: Icon(
                                                        Icons.perm_identity)),
                                              ),
                                              FormField(
                                                builder:
                                                    (FormFieldState state) {
                                                  return InputDecorator(
                                                    decoration: InputDecoration(
                                                      icon: const Icon(
                                                          Icons.report_problem),
                                                    ),
                                                    isEmpty:
                                                        _serverity == 'Low',
                                                    child:
                                                        new DropdownButtonHideUnderline(
                                                      child: new DropdownButton(
                                                        value: _serverity,
                                                        isDense: true,
                                                        onChanged:
                                                            (String newValue) {
                                                          setState(() {
                                                            _serverity =
                                                                newValue;
                                                          });
                                                        },
                                                        items: _serveritys.map(
                                                            (String value) {
                                                          return new DropdownMenuItem(
                                                            value: value,
                                                            child: new Text(
                                                                value,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black54)),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 30),
                                                width: double.infinity,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: FlatButton(
                                                        color: Colors.green,
                                                        textColor: Colors.white,
                                                        disabledColor:
                                                            Colors.grey,
                                                        disabledTextColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        splashColor:
                                                            Colors.blueAccent,
                                                        onPressed: () {
                                                          showDialog(
                                                              context:
                                                                  this.context,
                                                              child: ConfirmDialog(
                                                                  "Update Crack",
                                                                  "Do you want to update this crack?",
                                                                  Colors.green,
                                                                  widget.crack
                                                                      .crackId,
                                                                  description
                                                                      .text,
                                                                  _serverity,
                                                                  widget.dto,
                                                                  widget
                                                                      .crack));
                                                        },
                                                        child: Text(
                                                          "Update Cracks",
                                                          style: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: FlatButton(
                                                        color: Colors.blueGrey,
                                                        textColor: Colors.white,
                                                        disabledColor:
                                                            Colors.grey,
                                                        disabledTextColor:
                                                            Colors.black,
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        splashColor:
                                                            Colors.blueAccent,
                                                        onPressed: () {
                                                          setState(() {
                                                            _animatedHeight !=
                                                                    0.0
                                                                ? _animatedHeight =
                                                                    0.0
                                                                : _animatedHeight =
                                                                    300.0;
                                                            _animatedHeight !=
                                                                    0.0
                                                                ? _animatedBigHeight =
                                                                    650.0
                                                                : _animatedBigHeight =
                                                                    350.0;
                                                          });
                                                        },
                                                        child: Text(
                                                          "View Schedule",
                                                          style: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      Opacity(
                                        opacity: 0.501960813999176,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 1,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                              color: const Color(0xffb7b7b7),
                                              width: 0.5,
                                            ))),
                                      ),
                                      new AnimatedContainer(
                                        margin: EdgeInsets.only(top: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Color.fromRGBO(241, 241, 241, 1),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 5,
                                          //     blurRadius: 7,
                                          //     offset: Offset(1, 10), // changes position of shadow
                                          //   ),
                                          // ],
                                          //     gradient: LinearGradient(
                                          //       begin: Alignment.topLeft,
                                          //       end: Alignment.bottomRight,
                                          //         colors: [HexColor("#ffffff"),Color.fromRGBO(37, 49, 61, 1)]
                                          // )
                                        ),
                                        duration:
                                            const Duration(milliseconds: 120),
                                        child: SingleChildScrollView(
                                          child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                "FPT Repairer"),
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        labelText: 'Repairer',
                                                        hintText: "FPT Repair",
                                                        //prefixIcon: Icon(Icons.email),
                                                        icon: Icon(Icons
                                                            .perm_identity)),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                            text: "12/01/2021"),
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Repair time',
                                                        //prefixIcon: Icon(Icons.email),
                                                        icon: Icon(Icons
                                                            .av_timer_rounded)),
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                "Repair by FPT repairer..."),
                                                    style: TextStyle(
                                                        color: Colors.black54),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Repair description',
                                                        //prefixIcon: Icon(Icons.email),
                                                        icon: Icon(Icons
                                                            .av_timer_rounded)),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 30),
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20),
                                                          child: FlatButton(
                                                            color: Colors.green,
                                                            textColor:
                                                                Colors.white,
                                                            disabledColor:
                                                                Colors.grey,
                                                            disabledTextColor:
                                                                Colors.black,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            splashColor: Colors
                                                                .blueAccent,
                                                            onPressed: () {
                                                              _animatedHeight =
                                                                  100.0;
                                                            },
                                                            child: Text(
                                                              "Insert Schedule",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        height: _animatedHeight,
                                        width: double.infinity,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final Color color;
  final int crackId;
  final String description;
  final String severity;
  final UserDTO dto;
  final CrackDTO crack;
  ConfirmDialog(this.title, this.message, this.color, this.crackId,
      this.description, this.severity, this.dto, this.crack);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
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
                        title,
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              message,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            )),
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
                                        String result =
                                            await crackRepo.updateVerifyCrack(
                                                crackId, description, severity);
                                        if (result != null &&
                                            result.contains(
                                                "Update crack success")) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CrackScreen(
                                                      dto: dto,
                                                    )),
                                          );
                                        } else {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        }
                                      },
                                      child: Text(
                                        title,
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
          )),
    );
  }
}
