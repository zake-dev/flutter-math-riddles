import 'package:flutter/material.dart';
import 'package:math_riddles/utils/database.dart';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return _buildScoreboard(context);
  }

  static Widget _buildScoreboard(context) {
    return FutureBuilder(
      future: DB.getScore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You are now at,',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).accentColor,
                fontFamily: 'Monserrat',
                fontWeight: FontWeight.w200,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              '${snapshot.data} pts',
              textAlign: TextAlign.end,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).accentColor,
                fontFamily: 'Monserrat',
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            SizedBox(height: 3),
          ],
        );
      },
    );
  }
}
