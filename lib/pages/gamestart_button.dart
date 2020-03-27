import 'package:flutter/material.dart';
import 'package:math_riddles/utils/database.dart';

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
          width: 220,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              buttonText,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Montserrat',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () {
              print('pressed');
            },
          ),
        );
      },
    );
  }
}
