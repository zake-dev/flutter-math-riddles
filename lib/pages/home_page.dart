import 'package:flutter/material.dart';
import 'package:math_riddles/pages/gamestart_button.dart';
import 'package:math_riddles/pages/ranking_button.dart';
import 'package:math_riddles/pages/myrank_button.dart';
import 'package:math_riddles/pages/setting_button.dart';

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
          Align(alignment: Alignment(0.45, 0.0), child: _MainMenu(context)),
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
            alignment: Alignment(-1.14, -0.0),
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
        fontWeight: FontWeight.w300,
        fontSize: 100,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class _MainMenu extends Container {
  _MainMenu(BuildContext context)
      : super(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            // color: Colors.orange,
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              _buildGameButton(context),
              _buildButtons(context),
            ],
          ),
        );

  static Widget _buildTitle(context) {
    final username = 'Zake';
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello,',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Theme.of(context).accentColor,
            fontFamily: 'Monserrat',
            fontWeight: FontWeight.w200,
            fontSize: 35,
          ),
        ),
        Text(
          '$username',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Theme.of(context).accentColor,
            fontFamily: 'Monserrat',
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
      ],
    );
  }

  static Widget _buildGameButton(context) {
    var currentMessage = 'New Game';
    // currentMessage = 'Continue';
    return GameButton(context, currentMessage);
  }

  static Widget _buildButtons(context) {
    final buttons = [
      MyRankButton(context),
      RankingButton(context),
      SettingButton(context),
    ];

    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: buttons,
      ),
    );
  }
}
