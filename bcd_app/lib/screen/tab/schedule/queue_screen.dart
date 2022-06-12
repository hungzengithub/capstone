import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/repositories/worker_repository.dart';
import 'package:bcd_app/screen/dialog/noti_dialog.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_verify_box.dart';
import 'package:bcd_app/screen/tab/home/home_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class QueueScreen extends StatefulWidget {
  final bool isAdd;
  final UserDTO dto;
  QueueScreen(this.dto, this.isAdd);
  @override
  State<StatefulWidget> createState() {
    return __QueueScreenState();
  }
}

class __QueueScreenState extends State<QueueScreen> {
  List<int> listCrack = new List<int>();
  String todayDaysis = "12";
  List<WorkerDTO> _listWorkers = new List<WorkerDTO>();
  bool isAdd = false;
  String _dropDownValue = "";
  WorkerDTO _currentWorker;
  String _date = "Not set";
  String _time = "Not set";
  DateTime selectedDate;
  DateTime selectedTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetListCrackBloc _getBloc = new GetListCrackBloc();
    _getBloc.add(GetListCrackInQueue());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return Container(child: Text("xxx"));
        } else if (state is GetQueueSuccess) {
          _listWorkers = state.workerDTO;
          _currentWorker = state.workerDTO.first;
          _dropDownValue = state.workerDTO.first.name;
          isAdd = widget.isAdd;
          return Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Input Maintainance",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.teal,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              margin: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        1, 2), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: FormField(
                                    builder: (FormFieldState state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: const Icon(
                                            Icons.report_problem,
                                            color: Colors.teal,
                                            size: 20,
                                          ),
                                        ),
                                        child: new DropdownButtonHideUnderline(
                                          child: new DropdownButton(
                                            value: _currentWorker,
                                            isDense: true,
                                            onChanged: (WorkerDTO newValue) {
                                              setState(() {
                                                _currentWorker = newValue;
                                              });
                                            },
                                            items: _listWorkers
                                                .map((WorkerDTO value) {
                                              return new DropdownMenuItem(
                                                value: value,
                                                child: new Text(value.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Colors.teal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
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
                                                color: Colors.teal,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                " $_date",
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "  Change",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 4.0,
                              onPressed: () {
                                DatePicker.showTimePicker(context,
                                    theme: DatePickerTheme(
                                      containerHeight: 210.0,
                                    ),
                                    showTitleActions: true, onConfirm: (time) {
                                  setState(() {
                                    _time =
                                        '${time.hour}:${time.minute}:${time.second}';
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
                                                size: 18.0,
                                                color: Colors.teal,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                " $_time",
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "  Change",
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 7),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                onPressed: () async {
                                  int maintenanceWorkerId =
                                      _currentWorker.maintenanceWorkerId;
                                  DateTime date = new DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                      selectedTime.second);
                                  MaintainanceRepository repo =
                                      new MaintainanceRepository();
                                  String result =
                                      await repo.confirmMaintainance(
                                          maintenanceWorkerId, date.toString());
                                  if (result != null) {
                                    showDialog(
                                        context: this.context,
                                        child: NotiDiaglog(
                                            "Add Schedule",
                                            "Add schedule successfully!",
                                            Colors.green));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeScreen(dto: widget.dto)),
                                    );
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    "Add Schedule",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                color: Colors.teal,
                              ),
                            )
                          ],
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "   List Cracks:",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.teal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            isAdd
                                ? Container(
                                    margin: EdgeInsets.only(left: 135),
                                    child: RaisedButton(
                                        color: Colors.red,
                                        child: Text("Remove",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          CrackRepository repo =
                                              new CrackRepository();
                                          repo.removeFromQueue(listCrack);
                                        }),
                                  )
                                : Text(""),
                          ],
                        )),
                    Container(
                      height: 170,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: state.listDTO.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0
                                    ? Container(
                                        margin:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Text(
                                          state.listDTO[index].created
                                              .split("T")
                                              .first,
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : state.listDTO[index].createdDate.day !=
                                            state.listDTO[index - 1].createdDate
                                                .day
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 20),
                                            child: Text(
                                              state.listDTO[index].created
                                                  .split("T")
                                                  .first,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        : Container(),
                                CrackVerifyBox(
                                  widget.dto,
                                  isAdd,
                                  state.listDTO[index],
                                  listCrack,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
