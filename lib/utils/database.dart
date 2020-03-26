import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  static final firestore = Firestore.instance;
  static final users = firestore.collection('users');

  static void setUser(String name) async {
    final timestamp = DateTime.now().toIso8601String();
    final prefs = await SharedPreferences.getInstance();
    final documentReference = await users
        .add({'username': name, 'score': 0, 'last_played': timestamp});
    prefs.setInt('score', 0);
    prefs.setString('id', documentReference.documentID);
  }

  static Future<int> getScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score');
  }

  static void addScore(int point) async {
    final prefs = await SharedPreferences.getInstance();
    final score = prefs.getInt('score');
    final id = prefs.getString('id');
    prefs.setInt('score', score + point);
    users.document(id).updateData({'score': score + point});
  }
}
