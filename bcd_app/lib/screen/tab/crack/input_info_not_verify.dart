import 'package:bcd_app/screen/drawer/main_drawer.dart';

import 'package:flutter/material.dart';

class InputInfoNotVerify extends StatefulWidget {
  InputInfoNotVerify();
  @override
  State<StatefulWidget> createState() {
    return _InputInfoNotVerifyState();
  }
}

class _InputInfoNotVerifyState extends State<InputInfoNotVerify> {
  int _currentIndex = 0;
  PageController _pageController;
  List<String> appBarTitle = [
    "Notification",
    "Crack",
    "Home",
    "Schedule",
    "Account"
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        appBarTitle[_currentIndex],
        style: TextStyle(color: Colors.white),
      )),
      drawer: MainDrawer(),
      body: Container(
        child: Column(
          children: [
            // CrackNotVerifyBox("xx"),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 400,
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
                  border:
                      Border.all(color: const Color(0xff7e7e7e), width: 0.01),
                  color: const Color(0xffffffff)),
              child: Column(
                children: [
                  Container(
                      width: 300,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: 'Severity',
                                //prefixIcon: Icon(Icons.email),
                                icon: Icon(Icons.perm_identity)),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: 'Postion',
                                //prefixIcon: Icon(Icons.email),
                                icon: Icon(Icons.perm_identity)),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: 'Description',
                                //prefixIcon: Icon(Icons.email),
                                icon: Icon(Icons.perm_identity)),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
