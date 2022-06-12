import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/detail_page/crack_unscheduled_detail/crack_unschedule_detail.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/view_image_detail.dart';
import 'package:bcd_app/screen/tab/schedule/component/nocrack.dart';
import 'package:bcd_app/utils/flutter_constant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'component/bottom_sheet_unscheduled.dart';
import 'component/unschedule_loading.dart';
import 'component/unscheduled_box.dart';

class UnScheduledScreen extends StatefulWidget {
  final UserDTO dto;
  final bool isAdd;
  UnScheduledScreen(this.dto, this.isAdd);
  @override
  State<StatefulWidget> createState() {
    return __UnScheduledScreenState();
  }
}

class __UnScheduledScreenState extends State<UnScheduledScreen> {
  List<int> listCrack = new List<int>();
  GetListCrackBloc _getBloc = new GetListCrackBloc();
  List<int> listInQueue = List<int>();
  List<CrackDTO> listCrackInQueue = List<CrackDTO>();
  callbackRerender() {
    setState(() {
      setState(() {});
    });
  }

  String todayDaysis = "12";
  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListUnScheduledCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return UnScheduleLoading();
        } else if (state is GetListCrackSuccess) {
          return Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        Container(
                            height: 1000,
                            color: Color(0xff69d192),
                            width: 2,
                            margin:
                                EdgeInsets.only(left: 14, top: 20, bottom: 10)),
                        Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(left: 5, top: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xff69d192)),
                            child: Icon(Icons.done,
                                color: Colors.white, size: 12)),
                        Container(
                          height: MediaQuery.of(context).size.height - 120,
                          color: Colors.transparent,
                          child: ListView.builder(
                              padding: const EdgeInsets.only(top: 0.0),
                              itemCount: state.listDTO.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    headerDate(index, state.listDTO),
                                    UnScheduleBox(
                                      crack: state.listDTO[index],
                                      dto: widget.dto,
                                    )
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Positioned(
              //     bottom: 10,
              //     left: 20,
              //     top: 530,
              //     child: GestureDetector(
              //       onTap: () {
              //         showModalBottomSheet(
              //             context: context,
              //             builder: (ctx) {
              //               return BottomSheetUnSchedule(listInQueue,
              //                   listCrackInQueue, widget.dto, callbackRerender);
              //             });
              //       },
              //       child: Stack(
              //         children: [
              //           AnimatedContainer(
              //               duration: const Duration(milliseconds: 120),
              //               width: 60,
              //               height: 60,
              //               margin: EdgeInsets.only(right: 5),
              //               decoration: BoxDecoration(
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey.withOpacity(0.5),
              //                     spreadRadius: 2,
              //                     blurRadius: 1,
              //                     offset: Offset(
              //                         0, 3), // changes position of shadow
              //                   ),
              //                 ],
              //                 color: ILLUSTRATION_BLUE_COLOR,
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(100)),
              //               ),
              //               child: Stack(
              //                 children: [
              //                   Center(
              //                       child: Icon(Icons.home_repair_service,
              //                           color: Colors.white, size: 25)),
              //                   Positioned(
              //                       right: 5,
              //                       top: 0,
              //                       bottom: 35,
              //                       child: Container(
              //                         height: 10,
              //                         width: 20,
              //                         decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             borderRadius:
              //                                 BorderRadius.circular(100)),
              //                         child: Center(
              //                           child: Text(
              //                               listInQueue.length.toString(),
              //                               style: TextStyle(
              //                                   color: ILLUSTRATION_BLUE_COLOR,
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 18)),
              //                         ),
              //                       )),
              //                 ],
              //               )),
              //         ],
              //       ),
              //     )),
            ],
          );
        } else
          return NoCrackFounded();
      }),
    );
  }

  String convertDate(DateTime date) {
    String tmp = DateFormat('EEEE').format(date) +
        ", " +
        DateFormat('MMMM').format(date) +
        " " +
        date.day.toString() +
        ", " +
        date.year.toString();
    return tmp;
  }

  String convertTime(DateTime date) {
    String tmp =
        DateFormat('hh').format(date) + " : " + DateFormat('ss').format(date);
    return tmp;
  }

  Widget headerDate(int index, List<CrackDTO> listDTO) {
    if (index == 0 ||
        listDTO[index].createdDate.day != listDTO[index - 1].createdDate.day)
      return Container(
          width: 270,
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey[300].withOpacity(0.5),
              //     spreadRadius: 5,
              //     blurRadius: 7,
              //     offset: Offset(1, 10), // changes position of shadow
              //   ),
              // ],
              ),
          margin: EdgeInsets.only(top: 10, left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff69d192)),
                  child: Icon(Icons.done, color: Colors.white, size: 12)),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  convertDate(listDTO[index].createdDate ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ));
    return Container();
  }
}
