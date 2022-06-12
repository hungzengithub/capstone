import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_fixed_detail/crack_fixed_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_scheduled_detail/crack_schedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/screen/tab/schedule/manage_schedule_screen.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/maintainance/maintenance_result.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/repair_record_detail/repair_record_detail.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/scheduled_screen.dart';
import 'package:bcd_app/utils/constant.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/splash_screen.dart';
import 'package:flushbar/flushbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrackVerifyListDateTime extends StatefulWidget {
  final UserDTO dto;
  final List<CrackDTO> listCrack;
  final int statusIndex;
  CrackVerifyListDateTime(this.dto, this.listCrack, this.statusIndex);
  @override
  State<StatefulWidget> createState() {
    return _CrackVerifyListDateTimeState();
  }
}

class _CrackVerifyListDateTimeState extends State<CrackVerifyListDateTime> {
  GetListCrackBloc _getBloc = new GetListCrackBloc();
  String _status;

  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.statusIndex == 1) {
      _status = CrackStatus.UnscheduledForMaintenace;
    } else if (widget.statusIndex == 2) {
      _status = CrackStatus.ScheduledForMaintenace;
    } else if (widget.statusIndex == 3) {
      _status = CrackStatus.Fixed;
    } else
      _status = "All";
    _getBloc.add(GetCrackByFilter(widget.listCrack, _status));
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListVerifyCrackLoading) {
          return SplashScreen();
        } else if (state is GetListFilterSuccess) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.listCrack != null
                        ? Container(
                            height: MediaQuery.of(context).size.height - 230,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200].withOpacity(1),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  itemCount: widget.listCrack.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                            visible: _status == "All"
                                                ? true
                                                : _status ==
                                                        widget.listCrack[index]
                                                            .status
                                                    ? true
                                                    : false,
                                            child: FadeAnimation(
                                                0.5,
                                                VerifyBox2(
                                                    widget.listCrack[index],
                                                    widget.dto,
                                                    buttonValue(widget
                                                        .listCrack[index]),
                                                    buttonColor(widget
                                                        .listCrack[index])))),
                                      ],
                                    );
                                  }),
                            ),
                          )
                        : Container(child: Text("No scan for today")),
                  ],
                ),
              ),
            ),
          );
        } else
          return SplashScreen();
      }),
    );
  }
}

String buttonValue(CrackDTO crack) {
  if (crack.status == CrackStatus.UnqualifiedRepair ||
      (crack.status == CrackStatus.UnscheduledForMaintenace &&
          crack.severity == CrackSeverity.Low)) {
    return "track";
  } else if ((crack.status == CrackStatus.UnscheduledForMaintenace &&
      crack.maintenanceOrderId == -1 &&
      crack.severity != CrackSeverity.Low)) {
    return "Add to queue";
  } else if (crack.status == CrackStatus.ScheduledForMaintenace) {
    return "Repair Record";
  } else if (crack.status == CrackStatus.Fixed) {
    return "Fixed Result";
  }
  return "queue added";
}

Color buttonColor(CrackDTO crack) {
  if (crack.status == CrackStatus.UnqualifiedRepair ||
      (crack.status == CrackStatus.UnscheduledForMaintenace &&
          crack.severity == CrackSeverity.Low)) {
    return Colors.white;
  } else if ((crack.status == CrackStatus.UnscheduledForMaintenace &&
          crack.maintenanceOrderId == -1) ||
      crack.status == CrackStatus.UnqualifiedRepair) {
    return Colors.orange;
  } else if (crack.status == CrackStatus.ScheduledForMaintenace) {
    return Colors.blue[300];
  } else if (crack.status == CrackStatus.Fixed) {
    return Colors.deepPurple[200];
  } else
    return Colors.grey[400];
}

class VerifyBox2 extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final String buttonValue;
  final Color buttonColor;
  VerifyBox2(this.crack, this.dto, this.buttonValue, this.buttonColor);
  @override
  VerifyBoxState createState() =>
      VerifyBoxState(this.crack, this.dto, this.buttonValue, this.buttonColor);
}

class VerifyBoxState extends State<VerifyBox2> {
  final CrackDTO crack;
  final UserDTO dto;
  String buttonValue;
  Color buttonColor;
  VerifyBoxState(this.crack, this.dto, this.buttonValue, this.buttonColor);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200].withOpacity(1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(1, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (c) => ViewImageDetai(image: crack.image)));
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => Dialog(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10)),
                    //         child: Container(
                    //             height: 300,
                    //             color: Colors.red.withOpacity(0),
                    //             child: PhotoView(
                    //               minScale: 0.07,
                    //               maxScale: 1.1,
                    //               backgroundDecoration: BoxDecoration(
                    //                   color: Colors.red.withOpacity(0)),
                    //               imageProvider: NetworkImage(crack.image),
                    //             ))));
                  },
                  child: Container(
                      height: double.infinity,
                      width: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(crack.imageThumbnails)))),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Crack " + crack.crackId.toString(),
                              style: TextStyle(fontSize: 16)),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.home_repair_service,
                                color: ILLUSTRATION_PINK_COLOR, size: 18),
                            SizedBox(width: 10),
                            Text(
                              "Status",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40),
                            Text(
                              crack.status.split(" ").first,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.warning_amber_sharp,
                                color: ILLUSTRATION_PINK_COLOR, size: 18),
                            SizedBox(width: 10),
                            Text(
                              "Severity",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 40),
                            Text(
                              crack.severity ?? "N/A",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                crack.status ==
                                        CrackStatus.UnscheduledForMaintenace
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UnScheduleDetail(
                                                    crack: crack, dto: dto)),
                                      )
                                    : crack.status ==
                                            CrackStatus.ScheduledForMaintenace
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ScheduledDetail(
                                                        maintenanceOrderId:
                                                            null,
                                                        crack: crack,
                                                        dto: dto)),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FixedDetail(
                                                        maintenanceOrderId: crack
                                                            .maintenanceOrderId,
                                                        crack: crack,
                                                        dto: dto)));
                              },
                              child: Text(
                                "Detail",
                                style: TextStyle(
                                    color: ILLUSTRATION_PINK_COLOR,
                                    fontSize: 13),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                if ((crack.status ==
                                            CrackStatus
                                                .UnscheduledForMaintenace &&
                                        crack.maintenanceOrderId == -1) ||
                                    crack.status ==
                                        CrackStatus.UnqualifiedRepair) {
                                  List<int> listCrack = new List<int>();
                                  listCrack.add(crack.crackId);
                                  CrackRepository crackRepo =
                                      new CrackRepository();
                                  setState(() {
                                    buttonValue = "queue added";
                                    buttonColor = Colors.grey[400];
                                    crack.maintenanceOrderId = -2;
                                  });
                                  if (listCrack.length > 0) {
                                    String result =
                                        await crackRepo.addToQueue(listCrack);
                                    if (result.contains("failed"))
                                      result = APPMESSAGE.ADD_TO_QUEUE_FAIL;
                                    else
                                      result = APPMESSAGE.ADD_TO_QUEUE_SUCCESS;
                                    Flushbar(
                                      message: result,
                                      duration: Duration(seconds: 2),
                                    )..show(context);
                                  }
                                } else if (crack.status ==
                                    CrackStatus.ScheduledForMaintenace) {
                                  MaintainanceRepository repo =
                                      new MaintainanceRepository();
                                  MaintainanceDTO maintenance =
                                      await repo.getMaintainanceById(
                                          crack.maintenanceOrderId.toString());
                                  if (maintenance != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepairRecordDetail(
                                                dto: dto,
                                                maintenance: maintenance,
                                              )),
                                    );
                                  }
                                } else if (crack.status == CrackStatus.Fixed) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MaintainanceResult2(
                                              dto: widget.dto,
                                              crack: widget.crack,
                                              maintenanceOrderId: null,
                                            )),
                                  );
                                } else if (buttonValue == "queue added") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScheduleScreen(
                                              dto: dto,
                                              selectedTab: 1,
                                            )),
                                  );
                                }
                              },
                              child: Text(
                                buttonValue,
                                style:
                                    TextStyle(color: buttonColor, fontSize: 13),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
