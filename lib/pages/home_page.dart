import 'package:flutter/material.dart';
import 'package:math_riddles/pages/setting_button.dart';
import 'package:math_riddles/pages/ranking_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: [
          _BackGround(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SettingButton(context),
              RankingButton(context),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackGround extends Container {
  _BackGround(context)
      : super(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Container(
            alignment: Alignment(-1.07, -0.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLetter(context, 'M'),
                _buildLetter(context, 'A'),
                _buildLetter(context, 'T'),
                _buildLetter(context, 'H'),
              ],
            ),
          ),
        );

  static Widget _buildLetter(BuildContext context, String letter) {
    return Text(
      letter,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w100,
        fontSize: 100,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
