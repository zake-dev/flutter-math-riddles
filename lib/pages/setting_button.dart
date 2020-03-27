import 'package:flutter/material.dart';
import 'package:math_riddles/widget/funky_overlay.dart';
import 'package:math_riddles/pages/setting_page.dart';

class SettingButton extends Container {
  SettingButton(context)
      : super(
          width: 45.0,
          height: 45.0,
          margin: EdgeInsets.only(right: 8.0),
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: 1.2,
              ),
            ),
            elevation: 0.0,
            fillColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.settings,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FunkyOverlay(_buildPage()),
              );
            },
          ),
        );

  static List<Widget> _buildPage() {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 10, 30),
        child: SettingsPage(),
      ),
    ];
  }
}
