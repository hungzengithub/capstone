import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:flutter/material.dart';

import 'not_verify_bottom_button.dart';

class CrackNotVerifyBox extends StatelessWidget {
  final CrackDTO crack;
  final UserDTO dto;
  CrackNotVerifyBox(this.crack, this.dto);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(1, 10), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //         colors: [HexColor("#ffffff"),Color.fromRGBO(37, 49, 61, 1)]
            // )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 130,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(crack.image),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  )),
              NotVerifyBottomButton(crack, dto),
            ],
          ),
        ));
  }
}
