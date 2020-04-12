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
  final numberBoxSize = min(
      SizeConfig.safeBlockHorizontal * 10, SizeConfig.safeBlockVertical * 6);
  final numberFontSize =
      min(SizeConfig.safeBlockHorizontal * 6, SizeConfig.safeBlockVertical * 4);

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
              Container(
                height: gridSize,
                width: gridSize,
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: numberBoxSize,
                  width: numberBoxSize,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${isAnswer ? '?' : numbers[2]}',
                      style: TextStyle(fontSize: numberFontSize, height: 1),
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
              Container(
                height: gridSize,
                width: gridSize,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '▲',
                    style: TextStyle(height: 1),
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
              Container(
                height: gridSize,
                width: gridSize,
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: numberBoxSize,
                  width: numberBoxSize,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${numbers[1].abs()}',
                      style: TextStyle(fontSize: numberFontSize, height: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: gridSize, width: gridSize),
              Container(
                height: gridSize,
                width: gridSize,
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: numberBoxSize,
                  width: numberBoxSize,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${numbers[0].abs()}',
                      style: TextStyle(fontSize: numberFontSize, height: 1),
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
