import 'package:flutter/material.dart';

class GameButton extends Container {
  GameButton(BuildContext context, String currentMessage)
      : super(
          width: 220,
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 15),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text(
              currentMessage,
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
}
