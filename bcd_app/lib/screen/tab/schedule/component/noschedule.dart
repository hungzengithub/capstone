import 'package:flutter/material.dart';

class NoScheduleFounded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 250),
        child: Text(
          "No schedule for this day",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/notfoundschedule.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
