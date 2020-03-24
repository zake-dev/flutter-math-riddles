import 'package:flutter/material.dart';

class SettingButton extends RaisedButton {
  SettingButton(context)
      : super(
          shape: CircleBorder(
            side: BorderSide(color: Theme.of(context).accentColor),
          ),
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).accentColor,
          child: Icon(
            Icons.settings,
            color: Theme.of(context).accentIconTheme.color,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => _FunkyOverlay(),
            );
          },
        );
}

class _FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FunkyOverlayState();
}

class _FunkyOverlayState extends State<_FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

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
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text("Well hello there!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
