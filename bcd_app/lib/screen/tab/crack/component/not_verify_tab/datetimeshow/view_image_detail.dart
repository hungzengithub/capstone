import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImageDetai extends StatefulWidget {
  final String image;
  const ViewImageDetai({Key key, this.image}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ViewImageDetaiState();
  }
}

class ViewImageDetaiState extends State<ViewImageDetai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
            color: Colors.red.withOpacity(0),
            child: PhotoView(
              minScale: 0.07,
              maxScale: 1.1,
              backgroundDecoration:
                  BoxDecoration(color: Colors.red.withOpacity(0)),
              imageProvider: NetworkImage(widget.image),
            )));
  }
}
