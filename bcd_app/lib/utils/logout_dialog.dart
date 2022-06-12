import 'package:bcd_app/screen/login/login_page.dart';
import 'package:bcd_app/screen/tab/crack/component/not_verify_tab/datetimeshow/not_verify_screen_datetime.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogOutDialog extends StatelessWidget {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.only(top: 100, left: 30, right: 30),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: Constants.padding,
                            top: Constants.avatarRadius + Constants.padding,
                            right: Constants.padding,
                            bottom: Constants.padding),
                        margin: EdgeInsets.only(top: Constants.avatarRadius),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Constants.padding),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Are you sure you want to log out from BCD App",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (route) => false);
                                    },
                                    child: Text(
                                      "Logout ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red[600]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: Constants.padding,
                        right: Constants.padding,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: Constants.avatarRadius,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Constants.avatarRadius),
                            ),
                            child: Icon(
                              Icons.logout,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
