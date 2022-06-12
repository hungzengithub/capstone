import 'package:bcd_app/bloc/getmaintainancebyid/getmaintainancebyid_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/schedule/history_tab/component/history_result.dart';
import 'package:bcd_app/utils/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintainanceResult2 extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final int maintenanceOrderId;
  MaintainanceResult2(
      {@required this.crack, @required this.dto, this.maintenanceOrderId});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<MaintainanceResult2> {
  bool firstDisplay = true;
  GetMaintainanceByIdBloc _getBloc;

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
          return HistoryResult(dto: widget.dto, maintenance: state.dto);
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
