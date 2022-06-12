import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff8f8f8),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/droneloading.gif"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
