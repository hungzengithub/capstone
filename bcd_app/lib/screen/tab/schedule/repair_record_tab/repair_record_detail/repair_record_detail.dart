import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/screen/general/splash_container.dart';
import 'package:bcd_app/screen/tab/schedule/component/nocrack.dart';
import 'package:bcd_app/screen/tab/schedule/component/queue_carousel_container.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/evaluation_page/evaluation_screen.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../manage_schedule_screen.dart';

class RepairRecordDetail extends StatefulWidget {
  final UserDTO dto;
  final MaintainanceDTO maintenance;

  const RepairRecordDetail({Key key, this.dto, this.maintenance})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return __RepairRecordDetailState();
  }
}

class __RepairRecordDetailState extends State<RepairRecordDetail> {
  List<int> listCrack = new List<int>();
  String todayDaysis = "12";
  List<WorkerDTO> _listWorkers = new List<WorkerDTO>();
  bool isRerender = false;
  WorkerDTO _currentWorker;
  String _date = "Not set";
  String _time = "Not set";
  double animatedHeight;
  DateTime selectedDate;
  DateTime selectedTime;
  GetListCrackBloc _getBloc = new GetListCrackBloc();
  bool _allowRemove = false;
  String currentCrackView;
  TextEditingController expense = new TextEditingController(text: "");
  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat("yyyy-MM-dd")
        .parse(widget.maintenance.maintenanceDate.split(" ").first);
    selectedTime = DateFormat("hh:mm:ss")
        .parse(widget.maintenance.maintenanceDate.split(" ").last);
    _date = widget.maintenance.maintenanceDate.split(" ").first;
    String tmp = widget.maintenance.maintenanceDate.split(" ").last;
    _time = tmp.replaceRange(tmp.length - 3, tmp.length, ":00");
    currentCrackView = "1/" + widget.maintenance.cracks.length.toString();
    expense = TextEditingController(
        text: widget?.maintenance?.maintenanceExpense.toString() ?? "");
  }

  callbackSelect() {
    setState(() {
      setState(() {
        _allowRemove ? _allowRemove = false : _allowRemove = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(
      GetListWorker(),
    );
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return SplashContainer();
        } else if (state is GetQueueSuccess) {
          if (isRerender == false) {
            animatedHeight = 120;
            _currentWorker = state.workerDTO.first;
            _listWorkers = state.workerDTO;
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Text(
                "Repair record " +
                        widget.maintenance.maintenanceOrderId.toString() ??
                    "N/A",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              height: MediaQuery.of(context).size.height - 60,
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Total cracks: " +
                                          widget.maintenance.cracks?.length
                                              .toString() ??
                                      "0",
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 20),
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 180.0,
                                    enlargeCenterPage: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.8,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentCrackView =
                                            (index + 1).toString() +
                                                "/" +
                                                state.listDTO.length.toString();
                                      });
                                    }),
                                items: widget.maintenance.cracks.map((crack) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return QueueCarouselContainer(
                                          maintenanceOrderId: widget
                                              .maintenance.maintenanceOrderId,
                                          canRemove: _allowRemove,
                                          crack: crack,
                                          dto: widget.dto,
                                          callback: callbackSelect);
                                    },
                                  );
                                }).toList(),
                              ),
                              Center(
                                  child: Text(currentCrackView,
                                      style: TextStyle(fontSize: 16))),
                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  color: ILLUSTRATION_BLUE_COLOR_LOGIN,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(Icons.attach_money_rounded,
                                        color: ILLUSTRATION_BLUE_COLOR),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: TextFormField(
                                          controller: expense,
                                          keyboardType: TextInputType.number,
                                          onTap: () {
                                            if (expense.text == "0") {
                                              setState(() {
                                                expense.text = "";
                                              });
                                            }
                                          },
                                          maxLength: 7,
                                          style: TextStyle(
                                              color: ILLUSTRATION_BLUE_COLOR),
                                          decoration: InputDecoration(
                                              hintText: 'Expense',
                                              counterText: "",
                                              suffixText: "USD",
                                              hintStyle: TextStyle(
                                                  color:
                                                      ILLUSTRATION_BLUE_COLOR,
                                                  fontWeight: FontWeight.w300),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: ILLUSTRATION_BLUE_COLOR_LOGIN,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        minTime: DateTime.now()
                                            .subtract(Duration(days: 30)),
                                        maxTime: DateTime(2021, 12, 31),
                                        onConfirm: (date) {
                                      setState(() {
                                        _date =
                                            '${date.year}-${date.month}-${date.day}';
                                        selectedDate = date;
                                      });
                                      print(_date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.date_range,
                                                    size: 18.0,
                                                    color:
                                                        ILLUSTRATION_BLUE_COLOR,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    " $_date",
                                                    style: TextStyle(
                                                        color:
                                                            ILLUSTRATION_BLUE_COLOR,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "  Change",
                                          style: TextStyle(
                                              color: ILLUSTRATION_BLUE_COLOR,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ILLUSTRATION_BLUE_COLOR_LOGIN,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    DatePicker.showTimePicker(context,
                                        theme: DatePickerTheme(
                                          containerHeight: 210.0,
                                        ),
                                        showTitleActions: true,
                                        showSecondsColumn: false,
                                        onConfirm: (time) {
                                      setState(() {
                                        _time =
                                            '${time.hour}:${time.minute}:00';
                                        selectedTime = time;
                                      });
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 16.0,
                                                    color:
                                                        ILLUSTRATION_BLUE_COLOR,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    " $_time",
                                                    style: TextStyle(
                                                        color:
                                                            ILLUSTRATION_BLUE_COLOR,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "  Change",
                                          style: TextStyle(
                                              color: ILLUSTRATION_BLUE_COLOR,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ILLUSTRATION_BLUE_COLOR_LOGIN,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isRerender = true;
                                    });
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              height: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height: 300,
                                                    child: ListView.builder(
                                                        itemCount:
                                                            _listWorkers.length,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            10),
                                                                height:
                                                                    animatedHeight,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .grey[
                                                                      200],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Positioned(
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              75,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                width: 75,
                                                                                child: FlatButton(
                                                                                    child: Text(
                                                                                      "Select",
                                                                                      style: TextStyle(
                                                                                        fontSize: 12,
                                                                                        color: ILLUSTRATION_BLUE_COLOR,
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      setState(() {
                                                                                        _currentWorker = _listWorkers[index];
                                                                                      });
                                                                                      isRerender = true;
                                                                                      Navigator.of(context).pop();
                                                                                    }),
                                                                              ),
                                                                              // Container(
                                                                              //   width: 40,
                                                                              //   child: FlatButton(
                                                                              //       child: Icon(Icons.arrow_drop_down),
                                                                              //       onPressed: () {
                                                                              //         // setState(() {
                                                                              //         //   if (animatedHeight == 50) {
                                                                              //         //     animatedHeight = 150;
                                                                              //         //   } else
                                                                              //         //     animatedHeight = 50;
                                                                              //         //   isRerender = true;
                                                                              //         // });
                                                                              //       }),
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(width: 10),
                                                                                Container(
                                                                                  width: 30,
                                                                                  height: 30,
                                                                                  margin: EdgeInsets.only(top: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(10),
                                                                                    ),
                                                                                    image: DecorationImage(
                                                                                      image: NetworkImage("https://i.chungta.vn/2017/12/25/LogoFPT-2017-copy-3042-1513928-4697-9171-1514166704.jpg"),
                                                                                      fit: BoxFit.fill,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(width: 10),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: 10),
                                                                                  width: 200,
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        child: Row(children: [
                                                                                          Text(_listWorkers[index].name)
                                                                                        ]),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Visibility(
                                                                          visible: animatedHeight == 50
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 5),
                                                                            child:
                                                                                Row(children: [
                                                                              SizedBox(width: 15),
                                                                              Icon(Icons.phone_enabled, size: 18, color: ILLUSTRATION_BLUE_COLOR),
                                                                              SizedBox(width: 20),
                                                                              Text(
                                                                                _listWorkers[index].phone,
                                                                                style: TextStyle(
                                                                                  color: ILLUSTRATION_BLUE_COLOR,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          ),
                                                                        ),
                                                                        Visibility(
                                                                          visible: animatedHeight == 50
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 5),
                                                                            child:
                                                                                Row(children: [
                                                                              SizedBox(width: 15),
                                                                              Icon(Icons.house_sharp, size: 18, color: ILLUSTRATION_BLUE_COLOR),
                                                                              SizedBox(width: 20),
                                                                              Text(
                                                                                _listWorkers[index].address,
                                                                                style: TextStyle(
                                                                                  color: ILLUSTRATION_BLUE_COLOR,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          ),
                                                                        ),
                                                                        Visibility(
                                                                          visible: animatedHeight == 50
                                                                              ? false
                                                                              : true,
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 5),
                                                                            child:
                                                                                Row(children: [
                                                                              SizedBox(width: 15),
                                                                              Icon(Icons.email, size: 18, color: ILLUSTRATION_BLUE_COLOR),
                                                                              SizedBox(width: 20),
                                                                              Text(
                                                                                _listWorkers[index].email,
                                                                                style: TextStyle(
                                                                                  color: Colors.grey[500],
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.home_repair_service,
                                                    size: 16.0,
                                                    color:
                                                        ILLUSTRATION_BLUE_COLOR,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    _currentWorker.name,
                                                    style: TextStyle(
                                                        color:
                                                            ILLUSTRATION_BLUE_COLOR,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16.0),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "  Change",
                                          style: TextStyle(
                                              color: ILLUSTRATION_BLUE_COLOR,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () async {
                              double expenseCheck =
                                  parseExpense(expense.value.text);
                              if (expenseCheck == null || expenseCheck <= 0) {
                                Flushbar(
                                  message: "Please input a valid expense",
                                  duration: Duration(seconds: 1),
                                )..show(context);
                              } else if (_date == "Not set") {
                                Flushbar(
                                  message: "Please select date",
                                  duration: Duration(seconds: 1),
                                )..show(context);
                              } else if (_time == "Not set") {
                                Flushbar(
                                  message: "Please select time",
                                  duration: Duration(seconds: 1),
                                )..show(context);
                              } else if (widget.maintenance.cracks.length < 1) {
                                Flushbar(
                                  message: "No cracks in queue",
                                  duration: Duration(seconds: 1),
                                )..show(context);
                              } else {
                                DateTime date = new DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                    selectedTime.second);

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Color(0xfff8f8f8),
                                        title: Container(
                                          height: 150,
                                          color: Color(0xfff8f8f8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Update repair record",
                                                  style:
                                                      TextStyle(fontSize: 22)),
                                              SizedBox(height: 10),
                                              Text(
                                                  "Please wait for a few minutes",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16)),
                                              Container(
                                                width: double.infinity,
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/droneloading.gif"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                DateTime utcDate = date.toUtc();
                                int maintenanceWorkerId =
                                    _currentWorker.maintenanceWorkerId;
                                MaintainanceRepository repo =
                                    new MaintainanceRepository();
                                double expenseValue =
                                    double.parse(expense.value.text);
                                String result = await repo.updateMaintenance(
                                    maintenanceWorkerId,
                                    utcDate.toString(),
                                    widget.maintenance.maintenanceOrderId,
                                    expenseValue);
                                if (result != null &&
                                    result.contains("success")) {
                                  Navigator.of(context).pop();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScheduleScreen(
                                                flushBarMessage: APPMESSAGE
                                                    .UPDATE_REPAIR_SUCCESS,
                                                dto: widget.dto,
                                                selectedTab: 2,
                                              )),
                                      (Route<dynamic> route) => route.isFirst);
                                } else {
                                  Navigator.of(context).pop();
                                  Flushbar(
                                    message: APPMESSAGE.UPDATE_REPAIR_FAIL,
                                    duration: Duration(seconds: 1),
                                  )..show(context);
                                }
                              }
                            },
                            child: Container(
                              width: 100,
                              child: Text(
                                "Update",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                            color: ILLUSTRATION_PINK_COLOR,
                          ),
                          Stack(
                            children: [
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EvalutationScreen(
                                            widget.dto, widget.maintenance)),
                                  );
                                },
                                child: Container(
                                  width: 120,
                                  child: Text(
                                    "Evaluate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.0),
                                  ),
                                ),
                                color: ILLUSTRATION_GREY_HIGH_COLOR,
                              ),
                              // Positioned(
                              //   child: Container(
                              //     width: 20,
                              //     height: 20,
                              //     decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(100),
                              //       border: Border.all(
                              //         color: Colors
                              //             .teal, //                   <--- border color
                              //         width: 2.0,
                              //       ),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         widget.maintenance.cracks.length.toString(),
                              //         style: TextStyle(
                              //             color: Colors.black54,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else
          return NoCrackFounded();
      }),
    );
  }
}

Widget headerDate(int index, List<CrackDTO> listDTO) {
  if (index == 0 ||
      listDTO[index].createdDate.day != listDTO[index - 1].createdDate.day)
    return Container(
      width: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300].withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 10), // changes position of shadow
          ),
        ],
        color: Colors.teal,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.only(left: 20, top: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            listDTO[index].created.split(" ").first,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  return Container();
}

double parseExpense(String s) {
  return double.tryParse(s);
}
