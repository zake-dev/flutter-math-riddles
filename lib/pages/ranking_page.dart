import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;

class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NetworkConnection.check(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        // If there is no internet connection on device:
        if (!snapshot.data) {
          return _buildConnectionLossAlert();
        }

        return Text(
          'Ranking Board will be updated soon!',
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Widget _buildConnectionLossAlert() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Icon(MdiIcons.exclamationThick, size: 35),
        ),
        Text(
          'Sorry, Internet connection lost.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'Please check your Mobile/Wifi status.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 3),
      ],
    );
  }
}
