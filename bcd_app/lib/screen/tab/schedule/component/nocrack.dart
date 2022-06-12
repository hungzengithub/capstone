import 'package:flutter/material.dart';

class NoCrackFounded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 250),
        child: Text(
          "There are no more cracks",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/notfound.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
