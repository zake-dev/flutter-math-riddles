import 'dart:io';

import 'package:flutter/services.dart';
import 'package:math_riddles/providers/theme_notifier.dart';
import 'package:math_riddles/styles/theme.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';
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
      width: SizeConfig.safeBlockHorizontal * 75,
      // height: SizeConfig.safeBlockVertical * 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSettingTitle(
            context,
            'Settings',
            size: SizeConfig.safeBlockHorizontal * 6.7,
            fontWeight: FontWeight.w400,
            marginRight: SizeConfig.safeBlockHorizontal * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildSettingTitle(context, 'Select Theme',
                  size: SizeConfig.safeBlockHorizontal * 5, marginRight: 0),
              _buildSwitch(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSettingTitle(context, 'Diffiuclty',
                    size: SizeConfig.safeBlockHorizontal * 5, marginRight: 0),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                _buildDifficultyButton(),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Column(children: [
            _buildSettingTitle(context, 'Reset Userdata  ',
                size: SizeConfig.safeBlockHorizontal * 5, marginRight: 0),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            _buildResetButton(),
          ])
        ],
      ),
    );
  }

  Widget _buildSettingTitle(
    BuildContext context,
    String title, {
    double size,
    FontWeight fontWeight = FontWeight.w200,
    double marginRight,
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
        scale: SizeConfig.safeBlockHorizontal * 0.01 * 8,
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
      height: SizeConfig.safeBlockVertical * 5,
      margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 3),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).accentColor,
              width: SizeConfig.safeBlockHorizontal * 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Reset Progress',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
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
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 1,
                ),
                Text(
                  '**Application will be closed for the safety.**',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 3.7,
                    fontWeight: FontWeight.w600,
                    color: Colors.redAccent.shade700,
                  ),
                ),
              ],
              buttons: [
                FlatButton(
                    child: Text('Yes',
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5)),
                    onPressed: () async {
                      await DB.deleteCurrentUser();
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                      exit(0);
                    }),
                FlatButton(
                  child: Text('No',
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5)),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDifficultyButton() {
    return FutureBuilder(
      future: DB.getDifficultyOptions(),
      builder: (context, snapshot) {
        final easyModeOn = snapshot.data['easyMode'];
        final normalModeOn = snapshot.data['normalMode'];
        final hardModeOn = snapshot.data['hardMode'];

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 20,
                height: SizeConfig.safeBlockHorizontal * 9.5,
                decoration: BoxDecoration(
                  color: (easyModeOn)
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  border: Border.all(
                    color: (easyModeOn)
                        ? Colors.transparent
                        : Theme.of(context).accentColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    ' Easy',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockVertical * 2,
                      fontWeight: FontWeight.w600,
                      color: (easyModeOn)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                await DB.setDifficulty(
                    {'easyMode': true, 'normalMode': false, 'hardMode': false});
                setState(() {});
              },
            ),
            GestureDetector(
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 22,
                height: SizeConfig.safeBlockHorizontal * 9.5,
                decoration: BoxDecoration(
                  color: (normalModeOn)
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  border: Border(
                    top: BorderSide(
                        color: (normalModeOn)
                            ? Colors.transparent
                            : Theme.of(context).accentColor,
                        width: 1),
                    bottom: BorderSide(
                        color: (normalModeOn)
                            ? Colors.transparent
                            : Theme.of(context).accentColor,
                        width: 1),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Normal',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockVertical * 2,
                      fontWeight: FontWeight.w600,
                      color: (normalModeOn)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                await DB.setDifficulty(
                    {'easyMode': false, 'normalMode': true, 'hardMode': false});
                setState(() {});
              },
            ),
            GestureDetector(
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 20,
                height: SizeConfig.safeBlockHorizontal * 9.5,
                decoration: BoxDecoration(
                  color: (hardModeOn)
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  border: Border.all(
                    color: (hardModeOn)
                        ? Colors.transparent
                        : Theme.of(context).accentColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Hard ',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockVertical * 2,
                      fontWeight: FontWeight.w600,
                      color: (hardModeOn)
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                await DB.setDifficulty(
                    {'easyMode': false, 'normalMode': false, 'hardMode': true});
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
