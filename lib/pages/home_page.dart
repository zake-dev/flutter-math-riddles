import 'package:flutter/material.dart';
import 'package:math_riddles/pages/Init.dart';
import 'package:math_riddles/pages/gamestart_button.dart';
import 'package:math_riddles/pages/ranking_button.dart';
import 'package:math_riddles/pages/myrank_button.dart';
import 'package:math_riddles/pages/setting_button.dart';

class HomePage extends StatefulWidget {
  final user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  final user;

  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () {
    //   _showAlert(context);
    //   Future.delayed(Duration(seconds: 5), () {
    //     SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    //     exit(0);
    //   });
    // });
    if (user.username == null) {
      Init().init(context, user);
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Stack(
        children: [
          _BackGround(context),
          Align(
              alignment: Alignment(0.45, 0.0),
              child: _MainMenu(context, user.username)),
        ],
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Wifi"),
              content: Text("Wifi not detected. Please activate it."),
            ));
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
  _MainMenu(BuildContext context, String username)
      : super(
          width: 250,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context, username),
              GameButton(),
              _buildButtons(context),
            ],
          ),
        );

  static Widget _buildTitle(context, _username) {
    final username = (_username != null) ? _username : 'New User';
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
