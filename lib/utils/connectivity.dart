import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Future<void> initCheck(context) async {
  final hasConnection = await check();
  if (!hasConnection) {
    Future.delayed(Duration(seconds: 10), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      exit(0);
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet Connection!', textAlign: TextAlign.center),
        content: Text(
          'Sorry, This app requires mobile/wifi connection on play. App will be closed in 5 seconds.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
