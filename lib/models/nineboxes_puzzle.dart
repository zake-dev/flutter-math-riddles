import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_riddles/utils/size_config.dart';

class NineBoxesPuzzle extends StatelessWidget {
  final puzzle;

  NineBoxesPuzzle(this.puzzle);

  @override
  Widget build(BuildContext context) {
    return Center(
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
              _buildBox(puzzle['puzzle'][0], context),
              _buildBox(puzzle['puzzle'][1], context),
              _buildBox(puzzle['puzzle'][2], context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBox(puzzle['puzzle'][3], context),
              _buildBox('?', context),
              _buildBox(puzzle['puzzle'][4], context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBox(puzzle['puzzle'][5], context),
              _buildBox(puzzle['puzzle'][6], context),
              _buildBox(puzzle['puzzle'][7], context),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBox(number, context) {
    final boxSize = min(
        SizeConfig.safeBlockHorizontal * 20, SizeConfig.safeBlockVertical * 10);
    final fontSize = min(SizeConfig.safeBlockHorizontal * 6.5,
        SizeConfig.safeBlockVertical * 3.5);
    return Container(
      height: boxSize,
      width: boxSize,
      margin: EdgeInsets.all(SizeConfig.safeBlockVertical * 1.2),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).accentColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(fontSize: fontSize, height: 1),
        ),
      ),
    );
  }
}
