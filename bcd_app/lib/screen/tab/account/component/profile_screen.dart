import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String status;
  final UserDTO dto;
  ProfileScreen({@required this.status, @required this.dto});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      color: DEFAULT_COLOR_3,
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            margin: EdgeInsets.only(top: 50),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: ILLUSTRATION_GREY_HIGH_COLOR,
                                  width: 0.1),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://voz.vn/data/avatars/o/1674/1674252.jpg?1594502766'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                widget.dto.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "( " + widget.dto.userName + " )",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      )),
                  Container(
                    height: 300,
                    color: Colors.black12,
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 24,
                            right: 24,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 10, left: 30),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                fontSize: 14,
                                color: DEFAULT_COLOR,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 30, left: 30),
                          child: Text(
                            widget.dto.email,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10, left: 30),
                          child: Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 14,
                                color: DEFAULT_COLOR,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 30, left: 30),
                          child: Text(
                            widget.dto.address,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10, left: 30),
                          child: Text(
                            "Phone",
                            style: TextStyle(
                                fontSize: 14,
                                color: DEFAULT_COLOR,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 30, left: 30),
                          child: Text(
                            widget.dto.phoneNumber,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
