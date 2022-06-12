import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/drawer/main_drawer.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';

import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/logout_dialog.dart';
import 'package:flutter/material.dart';

import 'component/select_field.dart';

class AccountScreen extends StatefulWidget {
  final UserDTO dto;

  const AccountScreen({Key key, this.dto}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }
}

class AccountScreenState extends State<AccountScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(
          dto: widget.dto,
          selectedTab: 5,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 70),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 30),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 170,
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Container(
                                  width: 120,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://avatarfiles.alphacoders.com/126/126175.jpg"),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Positioned(
                                  bottom: 5,
                                  left: 20,
                                  child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey[200].withOpacity(1),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                          child: Text(widget.dto.userName))),
                                )
                              ],
                            ),
                          ),
                          FadeAnimation(
                            0.5,
                            Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeAnimation(
                                  0.5,
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.perm_identity,
                                              color: Colors.grey[600],
                                              size: 18),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 160,
                                            child: Text(
                                              widget.dto.name ?? "N?A",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                FadeAnimation(
                                  0.5,
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.email,
                                              color: Colors.grey[600],
                                              size: 18),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 160,
                                            child: Text(
                                              widget.dto.email ?? "N?A",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                FadeAnimation(
                                  0.5,
                                  Container(
                                      margin:
                                          EdgeInsets.only(top: 10, left: 10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_pin,
                                              color: Colors.grey[600],
                                              size: 18),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 160,
                                            child: Text(
                                              widget.dto.address ?? "N?A",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(height: 20),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Opacity(
                    opacity: 0.501960813999176,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: ILLUSTRATION_GREY_HIGH_COLOR,
                          width: 0.5,
                        ))),
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Phone Number",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.dto.phoneNumber ?? "N?A",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 80,
                            child: VerticalDivider(
                                color: ILLUSTRATION_GREY_HIGH_COLOR)),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Area",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.dto.locationName ?? "N?A",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: 0.501960813999176,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: ILLUSTRATION_GREY_HIGH_COLOR,
                          width: 0.5,
                        ))),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  SelectField(
                      Icons.vpn_key_rounded, "Change Password", widget.dto),
                  SelectField(Icons.help_center, "About BCD ", widget.dto),
                  // SelectField(LineIcons.sign_out, "Logout", widget.dto),
                ],
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 62,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Opacity(
                          opacity: 0.501960813999176,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: ILLUSTRATION_GREY_HIGH_COLOR,
                                width: 0.5,
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => LogOutDialog());
                          },
                          child: Container(
                              width: double.infinity,
                              height: 60,
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Icon(Icons.logout,
                                      color: Colors.redAccent, size: 20),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        color: DARK_TEXT_COLOR_1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

String convertToPhone(String phoneNumber) {
  final value = phoneNumber.replaceAllMapped(
      RegExp(r".{3}"), (match) => "${match.group(0)}-");
  return value;
}
