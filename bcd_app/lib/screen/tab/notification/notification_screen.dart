import 'package:bcd_app/bloc/getlistnotifications/getlistnotification_bloc.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/repositories/notification_repository.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_detail.dart';
import 'notification_loading.dart';

class NotificationScreen extends StatefulWidget {
  final UserDTO dto;

  const NotificationScreen({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NotificationScreenState();
  }
}

class NotificationScreenState extends State<NotificationScreen> {
  GetListNotificationBloc _getBloc = new GetListNotificationBloc();
  @override
  void dispose() {
    super.dispose();
    _getBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    _getBloc.add(GetListNotification());
    return BlocProvider(
      create: (context) => _getBloc,
      child: BlocBuilder<GetListNotificationBloc, GetListNotificationState>(
          builder: (context, state) {
        if (state is GetListNotificationLoading) {
          return NotificationLoading(
            dto: widget.dto,
          );
        } else if (state is GetListNotificationSuccess) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
              title: Text(
                'NOTIFICATION',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(32, 49, 82, 1),
                ),
              ),
            ),
            drawer: MainDrawer(
              dto: widget.dto,
              selectedTab: 2,
            ),
            body: ListView.builder(
              itemCount: state.listDTO.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      if (state.listDTO[index].isRead == false) {
                        NotificationRepository notiRepo =
                            new NotificationRepository();
                        notiRepo
                            .readNoti(state.listDTO[index].pushNotificationId);
                      }
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationDetail(
                                notificationDTO: state.listDTO[index])),
                      );
                    },
                    child: FadeAnimation(
                        1,
                        Container(
                            child: ListTile(
                          tileColor:
                              index % 2 == 1 ? Colors.grey[100] : Colors.white,
                          leading: Stack(
                            children: <Widget>[
                              new Icon(Icons.messenger,
                                  color: Colors.teal[200]),
                              state.listDTO[index].isRead == false
                                  ? Positioned(
                                      top: 1.0,
                                      right: 0.0,
                                      child: new Stack(
                                        children: <Widget>[
                                          new Icon(Icons.brightness_1,
                                              size: 10.0,
                                              color: Colors.red[800]),
                                          new Positioned(
                                            top: 1.0,
                                            right: 4.0,
                                            child: new Text("",
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          )
                                        ],
                                      ),
                                    )
                                  : Positioned(child: new Text(""))
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(state.listDTO[index].title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  )),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                  state.listDTO[index].created
                                      .split(".")
                                      .first
                                      .replaceFirst("T", " "),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black54,
                                  )),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                          subtitle: Text(state.listDTO[index].body,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              )),
                        ))));
              },
            ),
          );
        } else
          return Container(child: Text("error"));
      }),
    );
  }
}
