import 'package:flutter/material.dart';
import 'package:math_riddles/pages/Init.dart' as Init;
import 'package:math_riddles/widget/gamestart_button.dart';
import 'package:math_riddles/widget/myrank_button.dart';
import 'package:math_riddles/widget/ranking_button.dart';
import 'package:math_riddles/widget/setting_button.dart';
import 'package:math_riddles/utils/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Init.init(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: [
          _BackGround(context),
          Align(alignment: Alignment(0.45, 0.1), child: _MainMenu(context)),
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
          height: 400,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              // _buildScoreboard(context),
              GameButton(),
              _buildButtons(context),
            ],
          ),
        );

  static Widget _buildTitle(context) {
    return FutureBuilder(
        future: DB.getUsername(),
        builder: (context, snapshot) {
          final username = snapshot.hasData ? snapshot.data : 'New User';
          final nameFontSize =
              (username.length < 8) ? 35.0 : 35.0 - 1 * (username.length - 8);

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
                username,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: nameFontSize,
                ),
              ),
            ],
          );
        });
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
