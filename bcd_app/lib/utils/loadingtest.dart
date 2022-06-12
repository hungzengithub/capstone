import 'package:flutter/material.dart';

import 'loopanimator.dart';

class FavoriteMayLikeLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: ((MediaQuery.of(context).size.width * 161) / 375),
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: GridView.builder(
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return LoopWidgetAnimator(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 171 / 115,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: double.infinity,
                  height: 6,
                  color: Colors.grey[200],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, right: 15),
                  width: double.infinity,
                  height: 6,
                  color: Colors.grey[200],
                )
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 10,
          childAspectRatio: 171.0 / 151.0,
        ),
      ),
    ));
  }
}
