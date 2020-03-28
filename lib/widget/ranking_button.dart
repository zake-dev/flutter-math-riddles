import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/pages/ranking_page.dart';
import 'package:math_riddles/widget/funky_overlay.dart';

class RankingButton extends Container {
  RankingButton(context)
      : super(
          width: 45.0,
          height: 45.0,
          margin: EdgeInsets.only(right: 8.0),
          child: new RawMaterialButton(
            shape: new CircleBorder(
              side: BorderSide(
                color: Theme.of(context).accentColor,
                width: 1.2,
              ),
            ),
            elevation: 0.0,
            fillColor: Theme.of(context).primaryColor,
            child: Icon(
              MdiIcons.trophy,
              color: Theme.of(context).accentColor,
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
      Container(
        width: 350,
        padding: const EdgeInsets.all(15.0),
        child: RankingPage(),
      ),
    ];
  }
}
