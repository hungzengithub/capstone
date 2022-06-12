import 'package:flutter/material.dart';

class LeftCrackBoxImage extends StatelessWidget {
  LeftCrackBoxImage();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 130,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.designingbuildings.co.uk/w/images/6/6c/Cracking.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                ),
              ),
            ),
          ],
        ));
  }
}
