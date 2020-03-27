import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/pages/home_page.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;
import 'package:math_riddles/utils/database.dart';

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
  }

  @override
  Widget build(BuildContext conetxt) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      )),
    );

    final image = new Image(
      image: AssetImage('lib/assets/images/Math.png'),
      height: 300,
    );

    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: image,
      ),
    );
  }

  void init() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final deviceID = androidInfo.androidId;
    await DB.updateUser(deviceID);
    await DB.fetchData(deviceID);
  }
}