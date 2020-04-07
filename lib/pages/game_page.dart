import 'dart:async';

import 'package:facebook_audience_network/ad/ad_rewarded.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/models/multiline_puzzle.dart';
import 'package:math_riddles/models/oneline_puzzle.dart';
import 'package:math_riddles/pages/success_page.dart';
import 'package:math_riddles/utils/database.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/funky_overlay.dart';
import 'package:math_riddles/widget/setting_button.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = new TextEditingController();

  bool hintShowed = false;
  Future<Map<String, dynamic>> puzzle;
  String type, hint, answer;
  List<dynamic> workout;
  int point;

  @override
  initState() {
    super.initState();
    _getPuzzle();
  }

  _getPuzzle() async {
    final _puzzle = DB.getRandomPuzzle();
    setState(() {
      puzzle = _puzzle;
      hintShowed = false;
    });
  }

  _setPuzzleData(data) {
    this.type = data['type'];
    this.hint = data['hint'];
    this.answer = data['answer'];
    this.workout = data['workout'];
    this.point = data['point'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildAppBar(), _buildPuzzle(), _buildKeyboard()],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 95,
      height: SizeConfig.safeBlockVertical * 7,
      margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 12,
            height: SizeConfig.safeBlockHorizontal * 12,
            child: RawMaterialButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: Theme.of(context).accentColor,
                  width: SizeConfig.safeBlockHorizontal * 0.2,
                ),
              ),
              elevation: 0.0,
              fillColor: Theme.of(context).primaryColor,
              child: Icon(
                MdiIcons.arrowLeft,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SettingButton(context),
        ],
      ),
    );
  }

  Widget _buildPuzzle() {
    return FutureBuilder(
        future: puzzle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final puzzleData = snapshot.data;
          _setPuzzleData(puzzleData);

          // Choose Puzzle Type
          final puzzleContainer = (type == 'oneLine')
              ? OneLinePuzzle(puzzleData)
              : (type == 'multiLine')
                  ? MultiLinePuzzle(puzzleData)
                  : Text('Not found');

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            width: SizeConfig.safeBlockHorizontal * 95,
            height: SizeConfig.safeBlockVertical * 63,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment(0, -0.98),
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(color: Theme.of(context).accentColor),
                        children: <TextSpan>[
                          TextSpan(
                              text: (point < 4)
                                  ? 'Easy'
                                  : (point < 8) ? 'Medium' : 'Hard',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (point < 4)
                                    ? Colors.green
                                    : (point < 8) ? Colors.amber : Colors.red,
                              )),
                          TextSpan(text: '  $point points'),
                        ],
                      ),
                    )),
                puzzleContainer,
              ],
            ),
          );
        });
  }

  Widget _buildKeyboard() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 95,
      height: SizeConfig.safeBlockVertical * 25,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInputBox(),
              _buildHintButton(),
              _buildEnterButton()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeypadButton('1'),
              _buildKeypadButton('2'),
              _buildKeypadButton('3'),
              _buildKeypadButton('4'),
              _buildKeypadButton('5'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildKeypadButton('6'),
              _buildKeypadButton('7'),
              _buildKeypadButton('8'),
              _buildKeypadButton('9'),
              _buildKeypadButton('0'),
            ],
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1.5),
        ],
      ),
    );
  }

  Widget _buildInputBox() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 36,
      height: SizeConfig.safeBlockVertical * 5.5,
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(color: Theme.of(context).accentColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Answer",
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontFamily: 'Montserrat'),
      ),
    );
  }

  Widget _buildHintButton() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 17,
      height: SizeConfig.safeBlockVertical * 5.5,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0.0,
        fillColor: Theme.of(context).primaryColor,
        child: Icon(MdiIcons.lockQuestion),
        onPressed: () {
          showHintPage();
        },
      ),
    );
  }

  Widget _buildEnterButton() {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 36,
      height: SizeConfig.safeBlockVertical * 5.5,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0.0,
        fillColor: Theme.of(context).primaryColor,
        child: Text(
          'Enter',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
          ),
        ),
        onPressed: () {
          if (_controller.text == answer) {
            showDialog(
                context: context,
                builder: (_) => FunkyOverlay([
                      Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                        child: SuccessPage(),
                      )
                    ]));
            DB.addScore(point);
            _controller.clear();
            _getPuzzle();
          } else {
            showDialog(
                context: context,
                builder: (_) => FunkyOverlay([
                      Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
                        child: _buildWrongPage(),
                      )
                    ]));
            _controller.clear();
          }
        },
      ),
    );
  }

  Widget _buildKeypadButton(String buttonText) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 17,
      height: SizeConfig.safeBlockVertical * 7,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0.0,
        fillColor: Theme.of(context).primaryColor,
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
          ),
        ),
        onPressed: () {
          _controller.text += buttonText;
        },
      ),
    );
  }

  Widget _buildWrongPage() {
    return Container(
      child: Column(
        children: [
          Text(
            'Wrong!',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).accentColor,
              fontFamily: 'Monserrat',
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.safeBlockHorizontal * 7,
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Icon(MdiIcons.alertCircle, size: SizeConfig.safeBlockHorizontal * 15),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text(
            'Do you need some help?',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).accentColor,
              fontFamily: 'Monserrat',
              fontWeight: FontWeight.w300,
              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: SizeConfig.safeBlockHorizontal * 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Hint',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  showHintPage();
                },
              ),
              SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: SizeConfig.safeBlockHorizontal * 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  _getPuzzle();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void showHintPage() {
    showDialog(
      context: context,
      builder: (_) => FunkyOverlay(
        [
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Get Hint or Solution!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: SizeConfig.safeBlockHorizontal * 4.7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MdiIcons.video),
                      Text('      Watch Ads for Hint.    ')
                    ],
                  ),
                  onPressed: () async {
                    hintShowed = false;
                    FacebookRewardedVideoAd.loadRewardedVideoAd(
                      placementId: "710644546346434_710647189679503",
                      listener: (result, value) {
                        if (result == RewardedVideoAdResult.LOADED)
                          FacebookRewardedVideoAd.showRewardedVideoAd();
                        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
                          hintShowed = true;
                          Navigator.of(context).pop();
                          showHint();
                        }
                        if (result == RewardedVideoAdResult.ERROR) {
                          _showAdFailed();
                        }
                      },
                    );
                  },
                ),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(MdiIcons.video),
                      Text('  Watch Ads for Solution.')
                    ],
                  ),
                  onPressed: () async {
                    if (!hintShowed) {
                      _showHintFirst();
                    } else {
                      FacebookRewardedVideoAd.loadRewardedVideoAd(
                        placementId: "710644546346434_710647189679503",
                        listener: (result, value) {
                          if (result == RewardedVideoAdResult.LOADED)
                            FacebookRewardedVideoAd.showRewardedVideoAd();
                          if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
                            Navigator.of(context).pop();
                            showWorkout();
                          }
                          if (result == RewardedVideoAdResult.ERROR) {
                            _showAdFailed();
                          }
                        },
                      );
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showAdFailed() {
    Timer(Duration(seconds: 1), () => Navigator.of(context).pop());
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Text(
            'No ads available now.',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showHintFirst() {
    Timer(Duration(seconds: 1), () => Navigator.of(context).pop());
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: Text(
            'See Hint first!',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockVertical * 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void showHint() {
    showDialog(
      context: context,
      builder: (_) => FunkyOverlay(
        [
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  hint,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showWorkout() {
    showDialog(
      context: context,
      builder: (_) => FunkyOverlay(
        [
          Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  workout.join('\n'),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.safeBlockHorizontal * 5.2,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
