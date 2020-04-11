import 'dart:math';

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
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTriangle(puzzle['puzzle'][1]),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 1),
                  _buildTriangle(puzzle['puzzle'][2], isAnswer: true),
                ],
              ),
            ],
          ),
        );
}

Widget _buildTriangle(numbers, {isAnswer = false}) {
  final gridSize = min(
      SizeConfig.safeBlockHorizontal * 13, SizeConfig.safeBlockVertical * 7);
  final numberFontSize = min(
      SizeConfig.safeBlockHorizontal * 6, SizeConfig.safeBlockVertical * 3.7);
  final triangleFontSize = min(
      SizeConfig.safeBlockHorizontal * 9, SizeConfig.safeBlockVertical * 6.2);

  return Container(
    // decoration: BoxDecoration(color: Colors.white),
    child: SizedBox(
      width: gridSize * 3,
      height: gridSize * 3,
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
              SizedBox(height: gridSize, width: gridSize),
              SizedBox(
                height: gridSize,
                width: gridSize,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '${isAnswer ? '?' : numbers[2]}',
                    style: TextStyle(
                      fontSize: numberFontSize,
                    ),
                  ),
                ),
              ),
              SizedBox(height: gridSize, width: gridSize),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: gridSize, width: gridSize),
              SizedBox(
                height: gridSize,
                width: gridSize,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '▲',
                    style: TextStyle(
                      fontSize: triangleFontSize,
                      height: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: gridSize, width: gridSize),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: gridSize,
                width: gridSize,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    '${numbers[1].abs()}',
                    style: TextStyle(
                      fontSize: numberFontSize,
                      height: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: gridSize, width: gridSize),
              SizedBox(
                height: gridSize,
                width: gridSize,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${numbers[0].abs()}',
                    style: TextStyle(
                      fontSize: numberFontSize,
                      height: 1,
                    ),
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
