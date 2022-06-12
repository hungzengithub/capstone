import 'package:bcd_app/utils/constant.dart';
import 'package:flutter/material.dart';

class FilterCrack extends StatefulWidget {
  String filterValue;
  final Function(String) callBack;
  FilterCrack({Key key, this.filterValue, this.callBack}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FilterCrackState();
  }
}

class FilterCrackState extends State<FilterCrack> {
  String _status;
  @override
  initState() {
    super.initState();
    _status = widget.filterValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: Text("Status ", style: TextStyle(fontSize: 16)),
            ),
            RadioListTile<String>(
              title: const Text('All',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              value: "All",
              groupValue: _status,
              onChanged: (String value) {
                setState(() {
                  _status = value;
                  widget.filterValue = _status;
                  widget.callBack(value);
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: const Text(CrackStatus.UnscheduledForMaintenace,
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              value: CrackStatus.UnscheduledForMaintenace,
              groupValue: _status,
              onChanged: (String value) {
                setState(() {
                  _status = value;
                  widget.filterValue = _status;
                  widget.callBack(value);
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: const Text(CrackStatus.ScheduledForMaintenace,
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              value: CrackStatus.ScheduledForMaintenace,
              groupValue: _status,
              onChanged: (String value) {
                setState(() {
                  _status = value;
                  widget.filterValue = _status;
                  widget.callBack(value);
                });
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<String>(
              title: const Text(CrackStatus.Fixed,
                  style: TextStyle(color: Colors.black, fontSize: 14)),
              value: CrackStatus.Fixed,
              groupValue: _status,
              onChanged: (String value) {
                setState(() {
                  _status = value;
                  widget.filterValue = _status;
                  widget.callBack(value);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
