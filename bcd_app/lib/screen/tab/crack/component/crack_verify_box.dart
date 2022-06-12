import 'package:bcd_app/objects/crackDTO.dart';
import 'package:bcd_app/objects/userDTO.dart';
import 'package:bcd_app/screen/tab/crack/component/verify_bottom_button.dart';
import 'package:flutter/material.dart';

import 'crack_detail_2.dart';

class CrackVerifyBox extends StatefulWidget {
  final CrackDTO crack;
  final UserDTO dto;
  final bool isAdd;
  final List<int> listCrack;

  CrackVerifyBox(this.dto, this.isAdd, this.crack, this.listCrack);
  @override
  State<StatefulWidget> createState() {
    return CrackVerifyBoxState();
  }
}

class CrackVerifyBoxState extends State<CrackVerifyBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isAdd) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CrackDetail2(crack: widget.crack, dto: widget.dto)),
          );
        }
      },
      child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            margin: EdgeInsets.only(left: 10),
            height: 130,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(1, 10), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [HexColor("#ffffff"),color]
              // )
            ),
            child: Stack(
              children: [
                Container(
                    child: Row(
                  children: [
                    Container(
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              child: Container(
                                height: 120,
                                width: 110,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(widget.crack.image),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        )),
                    VerifyButtonBottom(widget.crack),
                  ],
                )),
                widget.isAdd == true
                    ? Positioned(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              width: 20,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              child: Checkbox(
                                value: isChecked,
                                onChanged: (bool value) {
                                  setState(() {
                                    isChecked = value;
                                    if (isChecked) {
                                      widget.listCrack
                                          .add(widget.crack.crackId);
                                    } else {
                                      widget.listCrack.remove(widget.crack);
                                    }
                                  });
                                },
                              )),
                        ),
                      )
                    : Container()

                // Container(
                //     child: IconButton(
                //   icon: Icon(
                //     Icons.double_arrow_rounded,
                //     size: 30,
                //     color: crack.severity == "Low"
                //         ? Colors.yellowAccent
                //         : crack.severity == "Medium"
                //             ? Colors.orangeAccent
                //             : Colors.redAccent,
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               CrackDetail2(crack: crack, dto: dto)),
                //     );
                //   },
                // )),
              ],
            ),
          )),
    );
  }
}
