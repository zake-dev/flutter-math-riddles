import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final List<Widget> contents;
  final List<Widget> buttons;
  final double padding;

  CustomDialog({
    @required this.title,
    @required this.contents,
    @required this.buttons,
    this.padding = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 2.2,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              this.title,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Montserrat',
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              children: this.contents,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: this.buttons,
          )
        ],
      ),
    );
  }
}