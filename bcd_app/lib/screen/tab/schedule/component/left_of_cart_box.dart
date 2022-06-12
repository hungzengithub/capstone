import 'package:bcd_app/screen/navigation_screen.dart';
import 'package:bcd_app/screen/tab/crack/component/left_crack_box_image.dart';
import 'package:bcd_app/screen/tab/crack/component/verify_bottom_button.dart';
import 'package:bcd_app/screen/tab/home/home_screen.dart';
import 'package:bcd_app/screen/tab/schedule/component/cart_bottom_button.dart';
import 'package:bcd_app/screen/tab/schedule/component/history_button_bottom.dart';
import 'package:bcd_app/utils/bcd_utils.dart';
import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';

import 'history_detail.dart';

class LeftOfCartBox extends StatefulWidget {
  final Color color;
  final String status;
  final double _animatedWidth;
  final bool isCart;
  LeftOfCartBox(this.color, this.status, this._animatedWidth, this.isCart);
  @override
  State<StatefulWidget> createState() {
    return LeftOfCartBoxState();
  }
}

// ignore: must_be_immutable
class LeftOfCartBoxState extends State<LeftOfCartBox> {
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.only(left: 10),
      height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(1, 10), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [HexColor("#ffffff"),color]
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
                      height: double.infinity,
                      width: 10,
                      decoration: BoxDecoration(
                          color: widget.color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)))),
                  Container(
                    height: 120,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://www.designingbuildings.co.uk/w/images/6/6c/Cracking.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              )),
          CartBottomButton(widget.color, widget.status),
          AnimatedContainer(
            height: 120,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            duration: const Duration(milliseconds: 120),
            margin: EdgeInsets.only(left: 10),
            width: widget._animatedWidth,
            child: widget._animatedWidth == 30 && widget.isCart == false
                ? Checkbox(
                    value: checkBox,
                    onChanged: (bool value) {
                      setState(() {
                        this.checkBox = value;
                      });
                    },
                  )
                : widget.isCart == true && widget._animatedWidth == 30
                    ? Icon(
                        Icons.delete_outlined,
                        color: Colors.redAccent,
                      )
                    : Container(),
          )
        ],
      ),
    );
  }
}
