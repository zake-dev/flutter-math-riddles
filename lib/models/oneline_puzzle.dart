import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';

class OneLinePuzzle extends Center {
  OneLinePuzzle(puzzle)
      : super(
          child: SizedBox(
            width: SizeConfig.safeBlockHorizontal * 85,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                puzzle['puzzle'],
                style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 8),
              ),
            ),
          ),
        );
}
