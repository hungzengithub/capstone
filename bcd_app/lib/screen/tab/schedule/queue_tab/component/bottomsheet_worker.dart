import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/objects/workerDTO.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../worker_box.dart';

// ignore: must_be_immutable
class BottomSheetWorker extends StatefulWidget {
  final List<WorkerDTO> listWorker;
  final UserDTO dto;
  WorkerDTO currentWorker;

  BottomSheetWorker(this.listWorker, this.dto, this.currentWorker);
  @override
  State<StatefulWidget> createState() {
    return bottomSheetWorkerState();
  }
}

// ignore: camel_case_types
class bottomSheetWorkerState extends State<BottomSheetWorker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: widget.listWorker.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WorkerBox(
                            widget.listWorker[index], widget.currentWorker)
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
