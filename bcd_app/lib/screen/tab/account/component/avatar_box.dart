import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';

class AvatarBox extends StatelessWidget {
  final UserDTO dto;

  const AvatarBox({Key key, this.dto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 7,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: ILLUSTRATION_GREY_HIGH_COLOR, width: 0.01),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ILLUSTRATION_GREY_HIGH_COLOR, width: 2),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://voz.vn/data/avatars/o/1674/1674252.jpg?1594502766'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                dto.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                dto.email,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.black26),
              )),
        ],
      ),
    );
  }
}
