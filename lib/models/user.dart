class User {
  final _deviceID, _score, _darkModeOn;
  String _username;

  User(this._deviceID, this._username, this._score, this._darkModeOn);

  get deviceID => _deviceID;
  get username => _username;
  set username(username) {
    this._username = username;
  }

  get score => _score;
  get darkModeOn => _darkModeOn;
}
