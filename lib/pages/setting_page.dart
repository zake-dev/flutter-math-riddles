import 'dart:io';

import 'package:flutter/services.dart';
import 'package:math_riddles/providers/theme_notifier.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/widget/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildSettingTitle(
            context,
            'Settings',
            size: 25,
            fontWeight: FontWeight.w400,
            marginRight: 20,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSettingTitle(context, 'Select Theme'),
                _buildSwitch(),
              ],
            ),
          ),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildSettingTitle(
    BuildContext context,
    String title, {
    double size = 18.0,
    FontWeight fontWeight = FontWeight.w200,
    double marginRight = 0,
  }) {
    return Container(
      margin: EdgeInsets.only(right: marginRight),
      child: Text(
        title,
        style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: 'Montserrat',
          fontWeight: fontWeight,
          fontSize: size,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Container(
      child: Transform.scale(
        scale: 0.37,
        child: DayNightSwitch(
          value: _darkTheme,
          onChanged: (val) {
            setState(() {
              _darkTheme = val;
            });
            onThemeChanged(val, themeNotifier);
          },
        ),
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Widget _buildResetButton() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor, width: 1.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Reset',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CustomDialog(
              title: 'Userdata Reset',
              contents: [
                Text(
                  'Userdata cannot be restored if you reset once. Do you really want to reset your Userdata?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '**Application will be closed for the safety.**',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent.shade700,
                  ),
                ),
              ],
              buttons: [
                FlatButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      await DB.deleteCurrentUser();
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                      exit(0);
                    }),
                FlatButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
