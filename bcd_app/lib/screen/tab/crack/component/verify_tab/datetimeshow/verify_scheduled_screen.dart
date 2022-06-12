import 'package:bcd_app/data/data.dart';
import 'package:bcd_app/model/date_model.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_loading/crack_loading.dart';
import 'package:bcd_app/screen/tab/schedule/component/nocrack.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';

import 'verify_datetime_scroll.dart';

class VerifyCrackDatetimeScreen extends StatefulWidget {
  final UserDTO dto;
  final int statusIndex;
  VerifyCrackDatetimeScreen(this.dto, this.statusIndex);
  @override
  State<StatefulWidget> createState() {
    return __VerifyCrackDatetimeScreenState();
  }
}

class __VerifyCrackDatetimeScreenState
    extends State<VerifyCrackDatetimeScreen> {
  GetListCrackBloc _getBloc = new GetListCrackBloc();
  List<DateModel> dates = new List<DateModel>();
  @override
  void initState() {
    super.initState();
    dates = getDates();
  }

  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListVerifyCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return CrackLoading();
        } else if (state is GetListCrackSuccess) {
          return VerifyDateTimeScroll(
              widget.dto, state.listDTO, widget.statusIndex, null);
        } else
          return NoCrackFounded();
      }),
    );
  }
}
