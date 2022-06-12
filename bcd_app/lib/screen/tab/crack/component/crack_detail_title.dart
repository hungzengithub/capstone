import 'package:flutter/material.dart';

class CrackDetailTitle extends StatelessWidget {
  final String title;
  CrackDetailTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.green,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 25, fontFamily: "Montserrat", color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
