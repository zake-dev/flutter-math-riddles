import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/app_builder.dart';
import 'package:math_riddles/widget/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_riddles/utils/database.dart';

final _controller = TextEditingController();

Future<void> init(context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString('username') == null) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: CustomDialog(
          title: "Welcome!",
          contents: [
            Text(
              'Please enter a Username which will be recorded on Ranking Board.',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'Montserrat',
                fontSize: SizeConfig.safeBlockHorizontal * 4,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).accentColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.safeBlockHorizontal * 5,
                bottom: 0,
              ),
              child: TextField(
                controller: _controller,
                autocorrect: false,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 12,
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[^a-zA-Z0-9]')),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                ),
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'Montserrat',
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
          buttons: [
            Container(
              margin:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockHorizontal * 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Theme.of(context).accentColor,
                textColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal * 5,
                    right: SizeConfig.safeBlockHorizontal * 5,
                  ),
                  child: Text(
                    'Play',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                onPressed: () {
                  final username = _controller.text;
                  if (username.length < 4) {
                    showDialog(
                      context: context,
                      builder: (_) => CustomDialog(
                        title: 'Too Short!!',
                        contents: [
                          Text(
                            'Username cannot be less than 4 letters.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1,
                            ),
                          )
                        ],
                        buttons: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: SizeConfig.safeBlockHorizontal * 3),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.safeBlockHorizontal * 5,
                                  right: SizeConfig.safeBlockHorizontal * 5,
                                ),
                                child: Text(
                                  'OK',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1,
                                  ),
                                ),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    CircularProgressIndicator();
                    _setUserdata(username, context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _setUserdata(String username, BuildContext context) async {
  await DB.setUsername(username);
  AppBuilder.of(context).rebuild();
  Navigator.pop(context);
}
