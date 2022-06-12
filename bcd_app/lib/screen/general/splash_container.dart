import 'package:flutter/material.dart';

class SplashContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: initScreen(context),
    );
  }

  initScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            ),
          )
        ],
      ),
    );
  }
}
