import 'package:flutter/cupertino.dart';
import 'package:math_riddles/utils/size_config.dart';

class MultiLinePuzzle extends Center {
  MultiLinePuzzle(puzzle)
      : super(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  puzzle['puzzle'][0],
                  style: TextStyle(
                      height: 1.4,
                      fontSize: SizeConfig.safeBlockHorizontal * 8),
                ),
                Text(
                  puzzle['puzzle'][1],
                  style: TextStyle(
                      height: 1.4,
                      fontSize: SizeConfig.safeBlockHorizontal * 8),
                ),
                Text(
                  puzzle['puzzle'][2],
                  style: TextStyle(
                      height: 1.4,
                      fontSize: SizeConfig.safeBlockHorizontal * 8),
                ),
                Text(
                  puzzle['puzzle'][3],
                  style: TextStyle(
                      height: 1.4,
                      fontSize: SizeConfig.safeBlockHorizontal * 8),
                ),
              ],
            ),
          ),
        );
}
