import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/funky_overlay.dart';
import 'package:math_riddles/pages/setting_page.dart';

class SettingButton extends Container {
  SettingButton(context)
      : super(
          width: SizeConfig.safeBlockHorizontal * 12,
          height: SizeConfig.safeBlockHorizontal * 12,
          margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 2.5),
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: SizeConfig.safeBlockHorizontal * 0.3,
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
        padding: EdgeInsets.fromLTRB(
            SizeConfig.safeBlockHorizontal * 6,
            SizeConfig.safeBlockHorizontal * 6,
            SizeConfig.safeBlockHorizontal * 3,
            SizeConfig.safeBlockHorizontal * 6),
        child: SettingsPage(),
      ),
    ];
  }
}
