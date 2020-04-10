import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';

class TrianglePuzzle extends Center {
  TrianglePuzzle(puzzle)
      : super(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTriangle(puzzle['puzzle'][0]),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                  _buildTriangle(puzzle['puzzle'][1]),
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTriangle(puzzle['puzzle'][2]),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                  _buildTriangle(puzzle['puzzle'][3], isAnswer: true),
                ],
              ),
            ],
          ),
        );
}

Widget _buildTriangle(numbers, {isAnswer = false}) {
  return Container(
    // decoration: BoxDecoration(color: Colors.white),
    child: SizedBox(
      width: SizeConfig.safeBlockHorizontal * 39,
      height: SizeConfig.safeBlockVertical * 21,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                  width: SizeConfig.safeBlockHorizontal * 13),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 13,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${isAnswer ? '?' : numbers[2]}',
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                ),
              ),
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                  width: SizeConfig.safeBlockHorizontal * 13),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                  width: SizeConfig.safeBlockHorizontal * 13),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 13,
                child: Center(
                  child: Text(
                    '▲',
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 9),
                  ),
                ),
              ),
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                  width: SizeConfig.safeBlockHorizontal * 13),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 13,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '${numbers[1].abs()}',
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                ),
              ),
              SizedBox(
                  height: SizeConfig.safeBlockVertical * 7,
                  width: SizeConfig.safeBlockHorizontal * 13),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 7,
                width: SizeConfig.safeBlockHorizontal * 13,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${numbers[0].abs()}',
                    style:
                        TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
