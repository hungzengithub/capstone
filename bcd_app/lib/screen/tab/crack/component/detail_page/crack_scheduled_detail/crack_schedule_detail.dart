import 'package:bcd_app/bloc/getmaintainancebyid/getmaintainancebyid_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/maintainanceDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/maintainance_repository.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/screen/tab/schedule/repair_record_tab/repair_record_detail/repair_record_detail.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ScheduledDetail extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final int maintenanceOrderId;

  ScheduledDetail(
      {@required this.crack,
      @required this.dto,
      @required this.maintenanceOrderId});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ScheduledDetail> {
  bool firstDisplay = true;
  GetMaintainanceByIdBloc _getBloc;
  ScrollController _scrollController = ScrollController();
  double _bottomValue = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc = new GetMaintainanceByIdBloc(
        widget.maintenanceOrderId ?? widget.crack.maintenanceOrderId);
    _getBloc.add(GetMaintainanceById());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetMaintainanceByIdBloc, GetMaintainanceByIdState>(
          builder: (context, state) {
        if (state is GetMaintainanceByIdLoading) {
          return SplashScreen();
        } else if (state is GetMaintainanceByIdSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: const Text(
                "CRACK DETAIL",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            body: Container(
              child: Stack(
                children: [
                  Container(
                    child: NotificationListener<ScrollNotification>(
                      // ignore: missing_return
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollStartNotification) {
                          setState(() {
                            _bottomValue = -60;
                          });
                        } else if (scrollNotification
                            is ScrollEndNotification) {
                          setState(() {
                            _bottomValue = 0;
                          });
                        }
                      },
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (c) => ViewImageDetai(
                                                image:
                                                    widget.crack.image ?? "")));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 200,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.crack.imageThumbnails ??
                                                  "")),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Crack Infomation",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: Container(
                                              height: 1.0,
                                              color: ILLUSTRATION_BLUE_COLOR_2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.code_outlined,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "CrackID",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    widget.crack.crackId.toString() ?? "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.perm_device_information,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Accuracy",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    MyUtil.convertToPercent(
                                        widget.crack?.accuracy ?? 0),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Created Date",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    widget.crack.created ?? "",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Last modified",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    widget.crack.lastModified ?? "N/A",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_pin,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Position detail",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    widget.crack.description ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Repair record",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, top: 10),
                                            child: Container(
                                              height: 1.0,
                                              color: ILLUSTRATION_BLUE_COLOR_2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.home_repair_service_outlined,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Repairer",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    state.dto.maintenanceWorkerName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.storage_outlined,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Repair Status",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    state.dto.status,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Repair description",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    state.dto.description ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_view_day_outlined,
                                            color: ILLUSTRATION_PINK_COLOR,
                                            size: 16),
                                        SizedBox(width: 10),
                                        Text(
                                          "Repair Date",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    state.dto.maintenanceDate ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(height: 100)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: _bottomValue,
                    left: 0,
                    right: 0,
                    height: 60,
                    duration: new Duration(milliseconds: 300),
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 200,
                              height: 30,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(),
                                color: ILLUSTRATION_BLUE_COLOR_2,
                                child: Text(
                                  'VIEW REPAIR RECORD',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  MaintainanceRepository repo =
                                      new MaintainanceRepository();
                                  MaintainanceDTO maintenance =
                                      await repo.getMaintainanceById(widget
                                          .crack.maintenanceOrderId
                                          .toString());
                                  if (maintenance != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RepairRecordDetail(
                                                dto: widget.dto,
                                                maintenance: maintenance,
                                              )),
                                    );
                                  } else {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
