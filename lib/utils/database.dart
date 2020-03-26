import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_riddles/utils/connectivity.dart' as NetworkConnection;

class DB {
  static final firestore = Firestore.instance;

  static Future<void> updateUser(String deviceID) async {
    final hasConnection = await NetworkConnection.check();
    if (!hasConnection) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('hasRecord')) {
      return;
    }

    final timestamp = DateTime.now().toIso8601String();
    final score = prefs.getInt('score');
    firestore
        .collection('users')
        .document(deviceID)
        .updateData({'score': score, 'last_login': timestamp});
  }

  static Future<void> fetchData(String deviceID) async {
    final hasConnection = await NetworkConnection.check();
    if (!hasConnection) {
      return;
    }

    final document =
        await firestore.collection('users').document(deviceID).get();

    if (document.exists) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', document.data['username']);
      await prefs.setInt('score', document.data['score']);
    } else {
      await _initUser(deviceID);
    }
  }

  static Future<void> _initUser(String deviceID) async {
    final timestamp = DateTime.now().toIso8601String();
    await firestore
        .collection('users')
        .document(deviceID)
        .setData({'username': null, 'score': 0, 'last_login': timestamp});

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasRecord', true);
    await prefs.setString('deviceID', deviceID);
  }

  static Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final darkModeOn = prefs.getBool('darkMode') ?? true;
    return darkModeOn;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final deviceID = prefs.getString('deviceID');
    await prefs.setString('username', username);
    await firestore
        .collection('users')
        .document(deviceID)
        .setData({'username': username}, merge: true);
  }

  static Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score') ?? 0;
    return score;
  }

  static void addScore(int point) async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score');
    prefs.setInt('score', score + point);
  }
}
