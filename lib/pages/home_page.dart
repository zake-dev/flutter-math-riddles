import 'package:flutter/material.dart';
import 'package:math_riddles/pages/Init.dart' as Init;
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/custom_dialog.dart';
import 'package:math_riddles/widget/gamestart_button.dart';
import 'package:math_riddles/widget/myrank_button.dart';
import 'package:math_riddles/widget/ranking_button.dart';
import 'package:math_riddles/widget/setting_button.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:store_redirect/store_redirect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    initRate();
    checkUpdate();
  }

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

  void initRate() {
    RateMyApp rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      minLaunches: 5,
      remindDays: 4,
      remindLaunches: 10,
      googlePlayIdentifier: 'com.project317.infinite_math_riddles',
    );

    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this App please!', // The dialog title.
          message:
              'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
          rateButton: 'RATE', // The dialog "rate" button text.
          noButton: 'NO THANKS', // The dialog "no" button text.
          laterButton: 'MAYBE LATER', // The dialog "later" button text.
          dialogStyle: DialogStyle(), // Custom dialog styles.
          onDismissed: () =>
              rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
  }

  void checkUpdate() async {
    final currentVersion = await DB.getCurrentVersion();
    final latestVersion = await DB.getLatestVersion();
    if (currentVersion != latestVersion) {
      showDialog(
        context: context,
        builder: (_) => CustomDialog(
          title: 'Update Released',
          contents: [
            Text('v$latestVersion update has been released!'),
            Text('Do you want to update app now?'),
          ],
          buttons: [
            Container(
              height: SizeConfig.safeBlockVertical * 5,
              margin: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 1,
                  bottom: SizeConfig.safeBlockVertical * 2),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: SizeConfig.safeBlockVertical * 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Theme.of(context).primaryColor,
                child: Text('Update Now'),
                onPressed: () {
                  Navigator.of(context).pop();
                  StoreRedirect.redirect();
                },
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
            Container(
              height: SizeConfig.safeBlockVertical * 5,
              margin: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 1,
                  bottom: SizeConfig.safeBlockVertical * 2),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: SizeConfig.safeBlockVertical * 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Theme.of(context).primaryColor,
                child: Text('Maybe Later'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    }
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
        fontSize: SizeConfig.safeBlockHorizontal * 24,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}

class _MainMenu extends Container {
  _MainMenu(BuildContext context)
      : super(
          width: SizeConfig.safeBlockHorizontal * 60,
          height: SizeConfig.safeBlockVertical * 50,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              GameButton(),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              _buildButtons(context),
            ],
          ),
        );

  static Widget _buildTitle(context) {
    return FutureBuilder(
        future: DB.getUsername(),
        builder: (context, snapshot) {
          final username = snapshot.hasData ? snapshot.data : 'New User';
          final fontSize = (username.length < 8)
              ? SizeConfig.safeBlockHorizontal * 10
              : SizeConfig.safeBlockHorizontal * 10 -
                  SizeConfig.safeBlockHorizontal * 0.6 * (username.length - 8);

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
                  fontSize: fontSize,
                ),
              ),
              Text(
                username,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
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
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: buttons,
      ),
    );
  }
}
