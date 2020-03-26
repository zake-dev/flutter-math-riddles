import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:math_riddles/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class DB {
  static final firestore = Firestore.instance;

  static Future<User> getUser() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final deviceID = androidInfo.androidId;

    final document =
        await firestore.collection('users').document(deviceID).get();
    if (!document.exists) {
      _initUser(deviceID);
      return User(deviceID, null, 0, true);
    } else {
      await _fetchData(document);

      final timestamp = DateTime.now().toIso8601String();
      firestore
          .collection('users')
          .document(deviceID)
          .updateData({'last_login': timestamp});

      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');
      final score = prefs.getInt('score');
      final darkModeOn = prefs.getBool('darkMode') ?? true;
      return User(deviceID, username, score, darkModeOn);
    }
  }

  static void _initUser(String deviceID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceID', deviceID);
    prefs.setInt('score', 0);
    prefs.setBool('darkMode', true);

    final timestamp = DateTime.now().toIso8601String();
    firestore.collection('users').document(deviceID).setData(
      {
        'score': 0,
        'last_login': timestamp,
      },
      merge: true,
    );
  }

  static Future<void> _fetchData(DocumentSnapshot document) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', document.data['score']);
    print(document.data['username']);
    await prefs.setString('username', document.data['username']);
  }

  static Future<void> setUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceID = prefs.getString('deviceID');
    await firestore
        .collection('users')
        .document(deviceID)
        .setData({'username': name}, merge: true);
  }

  static Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score') ?? 0;
    return score;
  }

  static void addScore(int point) async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score');
    final deviceID = prefs.getString('deviceID');
    prefs.setInt('score', score + point);
    firestore
        .collection('users')
        .document(deviceID)
        .updateData({'score': score + point});
  }
}
