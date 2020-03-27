import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/pages/setting_button.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
        Center(
          child: Text(
            'This will be Main Game screen.',
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Montserrat',
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Align(alignment: Alignment(0.8, -0.8), child: SettingButton(context)),
      ],
    );
  }
}
