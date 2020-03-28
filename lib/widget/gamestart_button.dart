import 'package:flutter/material.dart';
import 'package:math_riddles/pages/game_page.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/slide_route.dart';

class GameButton extends StatefulWidget {
  @override
  _GameButtonState createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  @override
  Widget build(BuildContext context) {
    final score = DB.getScore();

    return FutureBuilder(
      future: score,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final buttonText = (snapshot.data == null || snapshot.data == 0)
            ? 'New Game'
            : 'Continue';
        return Container(
          width: SizeConfig.safeBlockHorizontal * 62,
          height: SizeConfig.safeBlockVertical * 7,
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical * 0.8),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              buttonText,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Montserrat',
                fontSize: SizeConfig.safeBlockHorizontal * 8,
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(SlideRoute(page: GamePage(), direction: 'left'));
            },
          ),
        );
      },
    );
  }
}
