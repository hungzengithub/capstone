import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/login/fade_animation.dart';
import 'package:bcd_app/screen/tab/account/component/profile_screen.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:bcd_app/utils/logout_dialog.dart';
import 'package:flutter/material.dart';

import 'change_password_2.dart';

class SelectField extends StatelessWidget {
  final UserDTO dto;
  final IconData icon;
  final String value;
  SelectField(this.icon, this.value, this.dto);
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
        0.5,
        GestureDetector(
          onTap: () {
            if (value == "Logout") {
              showDialog(context: context, builder: (_) => LogOutDialog());
            } else if (value == "Profile") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      status: null,
                      dto: dto,
                    ),
                  ));
            } else if (value == "Change Password") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(
                      dto: dto,
                    ),
                  ));
            }
          },
          child: Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(icon, color: Color(0xfffab696), size: 20),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        color: DARK_TEXT_COLOR_1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )),
        ));
  }
}
