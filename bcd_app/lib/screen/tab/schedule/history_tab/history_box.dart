import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/general/splash_container.dart';
import 'package:bcd_app/screen/tab/crack/component/verify_tab/crack_verify_box.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen1 extends StatefulWidget {
  final UserDTO dto;
  HistoryScreen1(this.dto);
  @override
  State<StatefulWidget> createState() {
    return _HistoryScreenState();
  }
}

class _HistoryScreenState extends State<HistoryScreen1> {
  GetListCrackBloc _getBloc = new GetListCrackBloc();

  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListHistoryCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return SplashContainer();
        } else if (state is GetListCrackSuccess) {
          return Container(
            child: SingleChildScrollView(
              child: Container(
                height: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   margin: EdgeInsets.only(left: 20, bottom: 10),
                    //   child: Text(
                    //     '2020 NOV',
                    //     style: TextStyle(
                    //
                    //         color: Colors.black54,
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w700),
                    //   ),
                    // ),
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
                      height: 520,
                      padding: EdgeInsets.symmetric(vertical: 10),
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
                                            EdgeInsets.only(left: 20, top: 10),
                                        child: Text(
                                          state.listDTO[index].created
                                              .split(" ")
                                              .first,
                                          style: TextStyle(
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
                                                  .split(" ")
                                                  .first,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        : Container(),
                                CrackVerifyBox(widget.dto, false,
                                    state.listDTO[index], null)
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
