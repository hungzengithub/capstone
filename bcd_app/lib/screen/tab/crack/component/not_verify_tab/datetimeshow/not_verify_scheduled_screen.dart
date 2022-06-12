import 'package:bcd_app/data/data.dart';
import 'package:bcd_app/model/date_model.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_loading/crack_loading.dart';
import 'package:bcd_app/screen/tab/schedule/component/nocrack.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';

import 'not_verify_datetime_scroll.dart';

class NotVerifyCrackDatetimeScreen extends StatefulWidget {
  final UserDTO dto;
  NotVerifyCrackDatetimeScreen(this.dto);
  @override
  State<StatefulWidget> createState() {
    return __NotVerifyCrackDatetimeScreenState();
  }
}

class __NotVerifyCrackDatetimeScreenState
    extends State<NotVerifyCrackDatetimeScreen> {
  List<int> listCrack = new List<int>();
  String todayDaysis = "12";
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  GetListCrackBloc _getBloc = new GetListCrackBloc();
  List<DateModel> dates = new List<DateModel>();
  List<DateTime> markedDates = [DateTime.now()];
  @override
  void initState() {
    super.initState();
    dates = getDates();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListNotVerifyCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return CrackLoading();
        } else if (state is GetListCrackSuccess) {
          return NotVerifyDateTimeScroll(widget.dto, state.listDTO);
        } else
          return NoCrackFounded();
      }),
    );
  }
}
