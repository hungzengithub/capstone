import 'package:bcd_app/objects/notificationDTO.dart';
import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  final NotificationDTO notificationDTO;
  const NotificationDetail({Key key, this.notificationDTO}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NotificationDetailState();
  }
}

class NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
        title: Text(
          'NOTIFICATION DETAIL',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(32, 49, 82, 1),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 250,
                      child: Text(widget.notificationDTO.title,
                          style: TextStyle(fontSize: 22, color: Colors.white)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, bottom: 10, top: 5),
                      child: Text(
                          widget.notificationDTO.created
                              .split(".")
                              .first
                              .replaceAll("T", " "),
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.grey.withOpacity(0.4), BlendMode.dstATop),
                      image: AssetImage("assets/notibackground3.jpg"),
                    ))),
            Container(
              margin: EdgeInsets.only(left: 10, top: 20),
              child: Text(widget.notificationDTO.body,
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
