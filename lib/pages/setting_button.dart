import 'package:flutter/material.dart';
import 'package:math_riddles/pages/funky_overlay.dart';

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
              builder: (_) => FunkyOverlay(_buildPage()),
            );
          },
        );

  static List<Widget> _buildPage() {
    return [
      Padding(
        padding: const EdgeInsets.all(50.0),
        child: Text("Well hello there!"),
      ),
    ];
  }
}
