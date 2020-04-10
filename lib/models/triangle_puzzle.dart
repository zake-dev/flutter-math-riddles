import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';

class TrianglePuzzle extends Center {
  TrianglePuzzle(puzzle)
      : super(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTriangle(puzzle['puzzle'][0]),
                  _buildTriangle(puzzle['puzzle'][1]),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTriangle(puzzle['puzzle'][2]),
                  _buildTriangle(puzzle['puzzle'][3], isAnswer: true),
                ],
              ),
            ],
          ),
        );
}

Widget _buildTriangle(numbers, {isAnswer = false}) {
  return SizedBox(
    width: SizeConfig.safeBlockHorizontal * 40,
    height: SizeConfig.safeBlockVertical * 20,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(),
            Text(
              '${numbers[0].abs()}',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
            ),
            SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(),
            Text(
              '▲',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 9),
            ),
            SizedBox()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${numbers[1].abs()}',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
            ),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 9.5),
            Text(
              '${isAnswer ? '?' : numbers[2]}',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 6),
            )
          ],
        ),
      ],
    ),
  );
}
