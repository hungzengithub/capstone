import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/userDTO.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'crack_not_verify_box.dart';
import 'package:bcd_app/data/data.dart';
import 'package:bcd_app/model/date_model.dart';

class CrackNotVerifyList extends StatefulWidget {
  final bool _switchValue;
  final UserDTO dto;
  CrackNotVerifyList(this._switchValue, this.dto);
  @override
  State<StatefulWidget> createState() {
    return _CrackNotVerifyListState();
  }
}

class _CrackNotVerifyListState extends State<CrackNotVerifyList> {
  List<DateModel> dates = new List<DateModel>();
  String todayDaysis = "12";
  @override
  void initState() {
    super.initState();
    dates = getDates();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetListCrackBloc _getBloc = new GetListCrackBloc();
    _getBloc.add(GetListNotVerifyCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return Container(child: Text("xxx"));
        } else if (state is GetListCrackSuccess) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                height: 1000,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 10),
                    //   color: Colors.white,
                    //   height: 60,
                    //   child: ListView.builder(
                    //       itemCount: dates.length,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         return DateTile(
                    //           weekDay: dates[index].weekDay,
                    //           date: dates[index].date,
                    //           isSelected: todayDaysis == dates[index].date,
                    //         );
                    //       }),
                    // ),
                    Container(
                      height: 500,
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
                                        margin: EdgeInsets.only(
                                            left: 20, bottom: 10, top: 10),
                                        child: Text(
                                          state.listDTO[index].created
                                              .split("T")
                                              .first,
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    : state.listDTO[index].createdDate.day !=
                                            state.listDTO[index - 1].createdDate
                                                .day
                                        ? Container(
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 10, top: 10),
                                            child: Text(
                                              state.listDTO[index].created
                                                  .split("T")
                                                  .first,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black54,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        : Container(),
                                CrackNotVerifyBox(
                                    state.listDTO[index], widget.dto),
                              ],
                            );
                          }),
                    ),
                    //_buildListCrack(state.listDTO),
                  ],
                ),
              ),
            ),
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}

// ignore: must_be_immutable
class DateTile extends StatelessWidget {
  String weekDay;
  String date;
  bool isSelected;
  DateTile({this.weekDay, this.date, this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xffFCCD00) : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            date,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            weekDay,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.black54,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

// // ignore: missing_return
// Widget _buildListCrack(List<CrackDTO> listDTO) {
//   return ListView.separated(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         CrackDTO dto = listDTO[index];
//         return CrackNotVerifyBox(l);
//       },
//       separatorBuilder: (context, index) {
//         return Divider(
//           height: 1,
//         );
//       },
//       itemCount: listDTO.length);
// }
