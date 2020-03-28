import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return _buildScoreboard(context);
  }

  static Widget _buildScoreboard(context) {
    return FutureBuilder(
      future: Future.wait([DB.getScore(), DB.getUsername()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          final int score = snapshot.data[0];
          final String username = snapshot.data[1];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Name',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.w200,
                  fontSize: SizeConfig.safeBlockHorizontal * 6.3,
                ),
              ),
              Text(
                '$username',
                textAlign: TextAlign.end,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
              Text(
                'Your Score',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.w200,
                  fontSize: SizeConfig.safeBlockHorizontal * 6.3,
                ),
              ),
              Text(
                '$score pts',
                textAlign: TextAlign.end,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
