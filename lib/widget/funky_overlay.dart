import 'package:flutter/material.dart';

class FunkyOverlay extends StatefulWidget {
  final widgets;

  FunkyOverlay(this.widgets);

  @override
  State<StatefulWidget> createState() => _FunkyOverlayState(widgets);
}

class _FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  List<Widget> widgets;

  _FunkyOverlayState(this.widgets);

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2.2,
                    ),
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
          ),
        ),
      ),
    );
  }
}
