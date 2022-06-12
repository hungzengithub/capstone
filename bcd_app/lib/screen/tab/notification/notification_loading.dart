import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class NotificationLoading extends StatefulWidget {
  final UserDTO dto;

  const NotificationLoading({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _NotificationLoadingState();
  }
}

class _NotificationLoadingState extends State<NotificationLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return SkeletonAnimation(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  child: ListTile(
                      tileColor:
                          index % 2 == 1 ? Colors.grey[50] : Colors.white,
                      leading: SkeletonAnimation(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 10,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Container())));
        },
      ),
    );
  }
}
