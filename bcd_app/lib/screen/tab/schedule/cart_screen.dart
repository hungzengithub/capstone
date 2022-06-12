import 'package:bcd_app/screen/tab/schedule/component/left_of_cart_box.dart';
import 'package:flutter/material.dart';

class CartScreenTab extends StatelessWidget {
  final Color color;
  final String value;
  final double _animatedWidth;
  final bool isCart;

  CartScreenTab(this.color, this.value, this._animatedWidth, this.isCart);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [LeftOfCartBox(color, value, _animatedWidth, isCart)],
        ));
  }
}
