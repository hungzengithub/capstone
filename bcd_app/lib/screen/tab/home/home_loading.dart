import 'package:bcd_app/utils/flutter_constant.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomeLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeLoadingState();
  }
}

class _HomeLoadingState extends State<HomeLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
          title: Text(
            'HOME',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(32, 49, 82, 1),
            ),
          ),
          actions: [],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140,
                    color: DEFAULT_COLOR,
                  )
                ],
              ),
            ),

            // Total Doc
            Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SkeletonAnimation(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        height: 20,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                        ),
                      ),
                    ),

                    Container(
                      width: 260,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: 20,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Opacity(
                            opacity: 0.501960813999176,
                            child: Container(
                                width: 250,
                                height: 1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: ILLUSTRATION_GREY_HIGH_COLOR,
                                  width: 0.5,
                                ))),
                          ),
                          SizedBox(height: 5),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                              SkeletonAnimation(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  height: 18,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.deepOrange, // button color
                                    child: InkWell(
                                      splashColor: Colors.red, // inkwell color
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: Icon(
                                            LineIcons.play,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Input video",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.green, // button color
                                    child: InkWell(
                                      splashColor: Colors.red, // inkwell color
                                      child: SizedBox(
                                          width: 56,
                                          height: 56,
                                          child: Icon(
                                            LineIcons.video_camera,
                                            color: Colors.white,
                                            size: 30,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Scan now",
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //OpacityLine(),
                  ],
                )),
          ],
        ));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromRGBO(32, 49, 82, 1)),
        title: Text(
          'HOME SCREEN',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(32, 49, 82, 1),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SkeletonAnimation(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                  child: ListTile(
                      tileColor:
                          index % 2 == 1 ? Colors.grey[50] : Colors.white,
                      leading: SkeletonAnimation(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.only(left: 15),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 20,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 10,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SkeletonAnimation(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.only(left: 15, top: 4),
                                height: 15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Container())));
        },
      ),
    );
  }
}
