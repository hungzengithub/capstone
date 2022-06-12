import 'package:bcd_app/bloc/getlistcracks/getlistcrack_bloc.dart';
import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/crack_repository.dart';
import 'package:bcd_app/screen/dialog/noti_dialog.dart';
import 'package:bcd_app/screen/tab/crack/component/crack_verify_box.dart';
import 'package:bcd_app/screen/tab/schedule/queue_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bcd_app/data/data.dart';
import 'package:bcd_app/model/date_model.dart';

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
  String todayDaysis = "12";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetListCrackBloc _getBloc = new GetListCrackBloc();
    _getBloc.add(GetListUnScheduledCrack());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListCrackBloc, GetListCrackState>(
          builder: (context, state) {
        if (state is GetListCrackLoading) {
          return Container(child: Text("xxx"));
        } else if (state is GetListCrackSuccess) {
          return Stack(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 530,
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
                                              fontSize: 18,
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
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        : Container(),
                                CrackVerifyBox(
                                  widget.dto,
                                  widget.isAdd,
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
              widget.isAdd
                  ? Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: 20,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: IconButton(
                            iconSize: 40,
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.add_circle),
                            color: Colors.green,
                            onPressed: () async {
                              CrackRepository crackRepo = new CrackRepository();
                              if (listCrack.length > 0) {
                                String result =
                                    await crackRepo.addToQueue(listCrack);
                                if (result != null) {
                                  // showDialog(
                                  //     context: this.context,
                                  //     child: NotiDiaglog(
                                  //         "Add to queue",
                                  //         "Add to queue successfully!",
                                  //         Colors.green));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QueueScreen(
                                            widget.dto, widget.isAdd)),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
