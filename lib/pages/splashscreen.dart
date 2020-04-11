import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/pages/home_page.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  initState() {
    super.initState();
    NetworkConnection.initCheck(context);
    init();
    FacebookAudienceNetwork.init();
  }

  @override
  Widget build(BuildContext conetxt) {
    SizeConfig().init(context);
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      )),
    );

    final image = new Image(
      image: AssetImage('lib/assets/images/Math.png'),
      height: SizeConfig.safeBlockHorizontal * 60,
    );

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: image,
      ),
    );
  }

  void init() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final deviceID = deviceInfo.androidId;
    await DB.updateUser(deviceID);
    await DB.fetchData(deviceID);

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('normalMode')) {
      await prefs.setBool('easyMode', false);
      await prefs.setBool('normalMode', true);
      await prefs.setBool('hardMode', false);
    }
  }
}
