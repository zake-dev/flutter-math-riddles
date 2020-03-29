import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        return Container(
          width: SizeConfig.safeBlockHorizontal * 80,
          height: SizeConfig.safeBlockVertical * 80,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(MdiIcons.trophy,
                      size: SizeConfig.safeBlockVertical * 3.5),
                  Text(
                    '  Hall of Fame',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockHorizontal * 5.6,
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 10,
                    height: SizeConfig.safeBlockHorizontal * 10,
                    child: RawMaterialButton(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: SizeConfig.safeBlockHorizontal * 0.3,
                        ),
                      ),
                      elevation: 0.0,
                      fillColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.refresh,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final deviceID = prefs.getString('deviceID');
                        await DB.updateUser(deviceID);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              _buildRankingBoard(),
            ],
          ),
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
          margin: EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 3),
          child: Icon(
            MdiIcons.exclamationThick,
            size: SizeConfig.safeBlockHorizontal * 10,
          ),
        ),
        Text(
          'Sorry, Internet connection lost.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockHorizontal * 4,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          'Please check your Mobile/Wifi status.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockHorizontal * 4,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildRankingBoard() {
    return FutureBuilder(
        future: DB.getRankers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final rankers = snapshot.data;

          return Expanded(
              child: SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 77,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: rankers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: SizeConfig.safeBlockVertical * 7.5,
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.safeBlockVertical * 1),
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: (index == 0)
                                ? Colors.red.shade200
                                : (index == 1)
                                    ? Colors.orange.shade200
                                    : (index == 2)
                                        ? Colors.amber.shade200
                                        : Theme.of(context).canvasColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text('${index + 1}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        SizeConfig.safeBlockVertical * 1.8,
                                    fontFamily: 'Montserrat',
                                  )),
                              Text('${rankers[index]['username']}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize:
                                          SizeConfig.safeBlockVertical * 1.8,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold)),
                              Text('${rankers[index]['score']}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        SizeConfig.safeBlockVertical * 1.8,
                                    fontFamily: 'Montserrat',
                                  )),
                            ],
                          ),
                        );
                      })));
        });
  }
}
