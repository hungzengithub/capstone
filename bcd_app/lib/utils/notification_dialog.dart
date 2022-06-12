import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationDialog extends StatelessWidget {
  final String title;
  final String message;

  NotificationDialog({Key key, this.title, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.only(bottom: 550, left: 10, right: 10),
      child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(width: 10),
              Container(
                  width: 5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10))),
              SizedBox(width: 5),
              Icon(
                Icons.track_changes,
                color: Colors.blue,
                size: 30,
              ),
              SizedBox(width: 10),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14)),
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
