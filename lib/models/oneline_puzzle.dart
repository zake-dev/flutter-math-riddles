import 'package:flutter/cupertino.dart';
import 'package:math_riddles/utils/size_config.dart';

class OneLinePuzzle extends Center {
  OneLinePuzzle(puzzle)
      : super(
          child: Text(
            puzzle['puzzle'],
            style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 8),
          ),
        );
}
