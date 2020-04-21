import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/pages/calculator_page.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/funky_overlay.dart';

class CalculatorButton extends Container {
  CalculatorButton(context)
      : super(
          width: SizeConfig.safeBlockHorizontal * 12,
          height: SizeConfig.safeBlockHorizontal * 12,
          margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 2.5),
          child: RawMaterialButton(
            shape: CircleBorder(
                // side: BorderSide(
                //   color: Theme.of(context).accentColor,
                //   width: SizeConfig.safeBlockHorizontal * 0.3,
                // ),
                ),
            elevation: 0.0,
            fillColor: Colors.teal.shade800,
            child: Icon(
              MdiIcons.calculator,
              size: SizeConfig.safeBlockVertical * 4.7,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => FunkyOverlay(_buildPage()),
              );
            },
          ),
        );

  static List<Widget> _buildPage() {
    return [
      Padding(
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 6),
        child: CalculatorPage(),
      ),
    ];
  }
}
