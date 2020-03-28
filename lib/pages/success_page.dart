import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Correct!',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).accentColor,
                fontFamily: 'Monserrat',
                fontWeight: FontWeight.w500,
                fontSize: SizeConfig.safeBlockHorizontal * 7,
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Icon(MdiIcons.checkCircle,
                size: SizeConfig.safeBlockHorizontal * 15),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            RichText(
              text: TextSpan(
                text: 'You are now at,',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.w200,
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                ),
                children: [
                  TextSpan(
                    text: ' ${snapshot.data}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' points'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
