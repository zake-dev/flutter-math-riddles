import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/pages/ranking_page.dart';
import 'package:math_riddles/utils/size_config.dart';
import 'package:math_riddles/widget/funky_overlay.dart';

class RankingButton extends Container {
  RankingButton(context)
      : super(
          width: SizeConfig.safeBlockHorizontal * 12,
          height: SizeConfig.safeBlockHorizontal * 12,
          margin: EdgeInsets.only(right: SizeConfig.safeBlockHorizontal * 2.5),
          child: new RawMaterialButton(
            shape: new CircleBorder(
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: SizeConfig.safeBlockHorizontal * 0.3,
              ),
            ),
            elevation: 0.0,
            fillColor: Theme.of(context).primaryColor,
            child: Icon(MdiIcons.trophy,
                color: Theme.of(context).accentColor,
                size: SizeConfig.safeBlockHorizontal * 5.5),
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
      Container(
        width: SizeConfig.safeBlockHorizontal * 80,
        padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 5),
        child: RankingPage(),
      ),
    ];
  }
}
