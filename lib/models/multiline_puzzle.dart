import 'package:flutter/cupertino.dart';
import 'package:math_riddles/utils/size_config.dart';

class MultiLinePuzzle extends Center {
  MultiLinePuzzle(puzzle)
      : super(
          child: Text(
            puzzle['puzzle'].join('\n'),
            style: TextStyle(
                height: 1.4, fontSize: SizeConfig.safeBlockHorizontal * 8),
          ),
        );
}
