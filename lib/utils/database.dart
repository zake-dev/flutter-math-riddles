import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';
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
    final score = prefs.getInt('score') ?? 0;
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
      await prefs.setString('deviceID', deviceID);
      await prefs.setString('username', document.data['username']);
      await prefs.setInt('score', document.data['score']);
      await prefs.setBool('hasRecord', true);
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
    final score = prefs.getInt('score') ?? 0;
    final newScore = (score + point < 0)
        ? 0
        : (score + point <= 1000000) ? score + point : 1000000;
    prefs.setInt('score', newScore);
  }

  static Future<void> deleteCurrentUser() async {
    // Clear UserPrefs
    final prefs = await SharedPreferences.getInstance();
    final deviceID = prefs.getString('deviceID');
    print('deviceID = $deviceID');
    await prefs.clear();

    // Clear Database
    await firestore.collection('users').document(deviceID).delete();
  }

  static Future<Map<String, dynamic>> getRandomPuzzle() async {
    final databaseInfo =
        await firestore.collection('admin').document('databaseInfo').get();
    final puzzlesCount = databaseInfo.data['puzzlesCount'];
    final targetDocID = Random().nextInt(puzzlesCount) + 1;
    final targetDoc =
        await firestore.collection('puzzles').document('$targetDocID').get();
    return targetDoc.data;
  }

  static Future<Map<String, dynamic>> getPuzzle(String id) async {
    final targetDoc = await firestore.collection('puzzles').document(id).get();
    return targetDoc.data;
  }

  static Future<List<Map<String, dynamic>>> getRankers() async {
    List<Map<String, dynamic>> rankers = [];
    final snapshot = await firestore
        .collection('users')
        .orderBy('score', descending: true)
        .limit(50)
        .getDocuments();
    snapshot.documents.forEach((p) => rankers.add(p.data));
    return rankers;
  }

  static Future<String> getCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getLatestVersion() async {
    final dbInfo =
        await firestore.collection('admin').document('databaseInfo').get();
    return dbInfo.data['latestVersion'];
  }

  static Future<Map<String, bool>> getDifficultyOptions() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'easyMode': prefs.getBool('easyMode'),
      'normalMode': prefs.getBool('normalMode'),
      'hardMode': prefs.getBool('hardMode')
    };
  }

  static Future<void> setDifficulty(Map<String, bool> options) async {
    final prefs = await SharedPreferences.getInstance();
    options.forEach((k, v) async => await prefs.setBool(k, v));
  }
}
