import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/screen/tab/schedule/component/nocrack.dart';
import 'package:bcd_app/screen/tab/schedule/component/queue_carousel_container.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../manage_schedule_screen.dart';
import 'component/remove_item_inqueue.dart';

class QueueScreen extends StatefulWidget {
  final bool isAdd;
  final UserDTO dto;
  QueueScreen(this.dto, this.isAdd);
  @override
  State<StatefulWidget> createState() {
    return QueueScreenState();
  }
}

class QueueScreenState extends State<QueueScreen> {
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
  TextEditingController expense = new TextEditingController(text: "0");
  GetListCrackBloc _getBloc = new GetListCrackBloc();

  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  String currentCrackView = "1/10";

  @override
  void initState() {
    super.initState();
    _getBloc.add(
      GetListCrackInQueue(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return SplashScreen();
        } else if (state is GetQueueSuccess) {
          if (isRerender == false) {
            animatedHeight = 120;
            _currentWorker = state.workerDTO.first;
            _listWorkers = state.workerDTO;
          }

          return Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListCrackCarousel(
                                listDTO: state.listDTO, dto: widget.dto),
                            // CarouselSlider(
                            //   options: CarouselOptions(
                            //       height: 180.0,
                            //       enlargeCenterPage: true,
                            //       aspectRatio: 16 / 9,
                            //       autoPlayCurve: Curves.fastOutSlowIn,
                            //       enableInfiniteScroll: false,
                            //       viewportFraction: 0.8,
                            //       onPageChanged: (index, reason) {
                            //         setState(() {
                            //           currentCrackView =
                            //               (index + 1).toString() +
                            //                   "/" +
                            //                   state.listDTO.length.toString();
                            //         });
                            //       }),
                            //   items: state.listDTO.map((crack) {
                            //     return Builder(
                            //       builder: (BuildContext context) {
                            //         return QueueCarouselContainer(
                            //             maintenanceOrderId: null,
                            //             canRemove: _allowRemove,
                            //             crack: crack,
                            //             dto: widget.dto,
                            //             callback: callbackSelect);
                            //       },
                            //     );
                            //   }).toList(),
                            // ),
                            // Center(
                            //     child: Text(currentCrackView,
                            //         style: TextStyle(fontSize: 16))),
                            SizedBox(height: 20),
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
                                                color: ILLUSTRATION_BLUE_COLOR,
                                                fontWeight: FontWeight.w300),
                                            contentPadding: EdgeInsets.fromLTRB(
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
                                      _time = '${time.hour}:${time.minute}:00';
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
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey[200],
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
                                                                          Alignment
                                                                              .centerRight,
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
                                                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
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
                                                                        visible: animatedHeight ==
                                                                                50
                                                                            ? false
                                                                            : true,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          child:
                                                                              Row(children: [
                                                                            SizedBox(width: 15),
                                                                            Icon(Icons.phone_enabled,
                                                                                size: 18,
                                                                                color: Colors.grey[400]),
                                                                            SizedBox(width: 20),
                                                                            Text(
                                                                              _listWorkers[index].phone,
                                                                              style: TextStyle(
                                                                                color: Colors.grey[500],
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible: animatedHeight ==
                                                                                50
                                                                            ? false
                                                                            : true,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          child:
                                                                              Row(children: [
                                                                            SizedBox(width: 15),
                                                                            Icon(Icons.house_sharp,
                                                                                size: 18,
                                                                                color: Colors.grey[400]),
                                                                            SizedBox(width: 20),
                                                                            Text(
                                                                              _listWorkers[index].address,
                                                                              style: TextStyle(
                                                                                color: Colors.grey[500],
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                        ),
                                                                      ),
                                                                      Visibility(
                                                                        visible: animatedHeight ==
                                                                                50
                                                                            ? false
                                                                            : true,
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          child:
                                                                              Row(children: [
                                                                            SizedBox(width: 15),
                                                                            Icon(Icons.email,
                                                                                size: 18,
                                                                                color: Colors.grey[400]),
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
                            } else if (state.listDTO.length < 1) {
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

                              DateTime utcDate = date.toUtc();
                              int maintenanceWorkerId =
                                  _currentWorker.maintenanceWorkerId;
                              MaintainanceRepository repo =
                                  new MaintainanceRepository();
                              String result = await repo.confirmMaintainance(
                                  maintenanceWorkerId,
                                  utcDate.toString(),
                                  expenseCheck ?? 0);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScheduleScreen(
                                    flushBarMessage:
                                        APPMESSAGE.RECORD_REPAIR_SUCCESS,
                                    dto: widget.dto,
                                    selectedTab: 2,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 100,
                            child: Text(
                              "Record Repair",
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
                                List<CrackDTO> listTmp = new List<CrackDTO>();
                                for (var dto in state.listDTO) {
                                  if (dto.severity == CrackSeverity.Medium) {
                                    listTmp.add(dto);
                                  }
                                }
                                showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) {
                                      return RemoveQueueItem(
                                          listCrack: listTmp, dto: widget.dto);
                                    });
                              },
                              child: Container(
                                width: 120,
                                child: Text(
                                  "Remove",
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
                            //         state.listDTO.length.toString(),
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

class ListCrackCarousel extends StatefulWidget {
  final List<CrackDTO> listDTO;
  final UserDTO dto;

  const ListCrackCarousel({Key key, this.listDTO, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ListCrackCarouselState();
}

class _ListCrackCarouselState extends State<ListCrackCarousel> {
  bool _allowRemove = false;

  callbackSelect() {
    setState(() {
      setState(() {
        _allowRemove ? _allowRemove = false : _allowRemove = true;
      });
    });
  }

  String currentCrackView;

  @override
  void initState() {
    super.initState();
    currentCrackView = "1/" + widget.listDTO.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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
                    currentCrackView = (index + 1).toString() +
                        "/" +
                        widget.listDTO.length.toString();
                  });
                }),
            items: widget.listDTO.map((crack) {
              return Builder(
                builder: (BuildContext context) {
                  return QueueCarouselContainer(
                      maintenanceOrderId: null,
                      canRemove: _allowRemove,
                      crack: crack,
                      dto: widget.dto,
                      callback: callbackSelect);
                },
              );
            }).toList(),
          ),
          Center(child: Text(currentCrackView, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

double parseExpense(String s) {
  return double.tryParse(s);
}
