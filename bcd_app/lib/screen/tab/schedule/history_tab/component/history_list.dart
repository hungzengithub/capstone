import 'package:bcd_app/bloc/getlistmaintainances/getlistmaintainance_bloc.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/schedule/component/noschedule.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'history_box.dart';

class HistoryList extends StatefulWidget {
  DateTime selectedDate;
  final UserDTO dto;
  HistoryList(this.selectedDate, this.dto);
  @override
  State<StatefulWidget> createState() {
    return _historyListState();
  }
}

// ignore: camel_case_types
class _historyListState extends State<HistoryList> {
  GetListMaintainanceBloc _getBloc;
  @override
  void initState() {
    super.initState();
    _getBloc = new GetListMaintainanceBloc(widget.selectedDate);
  }

  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListCompletedMaintainance());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListMaintainanceBloc, GetListMaintainanceState>(
          builder: (context, state) {
        if (state is GetlistMaintainanceLoading) {
          return Center(child: Text('Please wait its loading...'));
        } else if (state is GetlistMaintainanceSuccess) {
          String month = "";
          String day = "";
          if (widget.selectedDate.month < 10) {
            month = "0";
          }
          if (widget.selectedDate.day < 10) {
            day = "0";
          }
          month += widget.selectedDate.month.toString();
          day += widget.selectedDate.day.toString();
          String containSelected =
              widget.selectedDate.year.toString() + "-" + month + "-" + day;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300].withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 7,
                        offset: Offset(1, 10), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                      itemCount: state.listDTO.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return state.listDTO[index].maintenanceDate
                                    .contains(containSelected) &&
                                state.listDTO[index].status == "Completed"
                            ? HistoryBox(widget.dto, state.listDTO[index])
                            : Container();
                      }),
                ),
                SizedBox(height: 100)
              ],
            ),
          );
        } else
          return NoScheduleFounded();
      }),
    );
  }
}
