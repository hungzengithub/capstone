import 'dart:async';

import 'package:flutter/material.dart';

class Animator extends StatefulWidget {
  final Widget child;
  final Duration time;
  final bool allowRemove;
  Animator(this.child, this.time, this.allowRemove);
  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>
    with SingleTickerProviderStateMixin {
  Timer timer;
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    timer = Timer(widget.time, animationController.forward);
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        if (widget.allowRemove) {
          return Opacity(
            opacity: 1,
            child: Transform.translate(
              offset: Offset(0.0, (1 - animation.value) * 10),
              child: child,
            ),
          );
        } else
          return child;
      },
    );
  }
}

Timer timer;
Duration duration = Duration();
wait({int speedMs}) {
  if (timer == null || !timer.isActive) {
    timer = Timer(Duration(microseconds: 220), () {
      duration = Duration();
    });
  }
  duration += Duration(milliseconds: speedMs != null ? speedMs : 200);
  return duration;
}

class LoopCarousel extends StatelessWidget {
  final Widget child;
  final int speedMs;
  final bool allowRemove;
  LoopCarousel({this.child, this.speedMs, this.allowRemove});
  @override
  Widget build(BuildContext context) {
    return Animator(child, wait(speedMs: speedMs), allowRemove);
  }
}
