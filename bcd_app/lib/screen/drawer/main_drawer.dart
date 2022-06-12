import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/account/account_screen.dart';
import 'package:bcd_app/screen/tab/crack/crack_screen.dart';
import 'package:bcd_app/screen/tab/notification/notification_screen.dart';
import 'package:bcd_app/screen/tab/schedule/manage_schedule_screen.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/logout_dialog.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final UserDTO dto;
  final int selectedTab;
  const MainDrawer({Key key, this.dto, this.selectedTab}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: new BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  height: 200,
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          width: 85,
                          height: 85,
                          margin: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/bcd-logo.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5, top: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dto.userName,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: ILLUSTRATION_BLUE_COLOR_DRAWER),
                                ),
                                Container(
                                  width: 190,
                                  child: Text(
                                    dto.email ?? "N/A",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.501960813999176,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey[500],
                            width: 0.8,
                          ))),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // ListTile(
                      //   leading: Icon(Icons.home,
                      //       color: selectedTab == 1
                      //           ? ILLUSTRATION_BLUE_COLOR_DRAWER
                      //           : Colors.black87),
                      //   title: Text(
                      //     'Home',
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         color: selectedTab == 1
                      //             ? ILLUSTRATION_BLUE_COLOR_DRAWER
                      //             : Colors.black87),
                      //   ),
                      //   onTap: () {
                      //     Navigator.pushAndRemoveUntil(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomeScreen(dto: dto)),
                      //         (Route<dynamic> route) => route.isFirst);
                      //   },
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTab == 2
                                ? ILLUSTRATION_BLUE_COLOR_LOGIN
                                : Colors.white),
                        child: ListTile(
                          leading: Icon(Icons.notifications,
                              color: selectedTab == 2
                                  ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                  : Colors.grey[400]),
                          title: Text(
                            'Notification',
                            style: TextStyle(
                                fontSize: 15,
                                color: selectedTab == 2
                                    ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                    : Colors.black87),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationScreen(dto: dto)),
                                (Route<dynamic> route) => route.isFirst);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: selectedTab == 3
                                ? ILLUSTRATION_BLUE_COLOR_LOGIN
                                : Colors.white),
                        child: ListTile(
                          leading: Icon(Icons.report_problem_rounded,
                              color: selectedTab == 3
                                  ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                  : Colors.grey[400]),
                          title: Text(
                            'Crack',
                            style: TextStyle(
                                fontSize: 15,
                                color: selectedTab == 3
                                    ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                    : Colors.black87),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CrackScreen(dto: dto, page: 0)),
                                (Route<dynamic> route) => route.isFirst);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTab == 4
                                ? ILLUSTRATION_BLUE_COLOR_LOGIN
                                : Colors.white),
                        child: ListTile(
                          leading: Icon(
                            Icons.receipt_long,
                            color: selectedTab == 4
                                ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                : Colors.grey[400],
                          ),
                          title: Text(
                            'Repair Record',
                            style: TextStyle(
                                fontSize: 15,
                                color: selectedTab == 4
                                    ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                    : Colors.black87),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScheduleScreen(
                                          dto: dto,
                                          selectedTab: 0,
                                        )),
                                (Route<dynamic> route) => route.isFirst);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTab == 5
                                ? ILLUSTRATION_BLUE_COLOR_LOGIN
                                : Colors.white),
                        child: ListTile(
                          leading: Icon(Icons.account_box_rounded,
                              color: selectedTab == 5
                                  ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                  : Colors.grey[400]),
                          title: Text(
                            'Account',
                            style: TextStyle(
                                fontSize: 15,
                                color: selectedTab == 5
                                    ? ILLUSTRATION_BLUE_COLOR_DRAWER
                                    : Colors.black87),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AccountScreen(dto: dto)),
                                (Route<dynamic> route) => route.isFirst);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 60,
                color: Colors.white,
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.501960813999176,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey[500],
                                width: 0.8,
                              ))),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.grey[400]),
                      title: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      onTap: () {
                        showDialog(
                            context: context, builder: (_) => LogOutDialog());
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
