import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/pages/funky_overlay.dart';

class RankingButton extends RaisedButton {
  RankingButton(context)
      : super(
          shape: CircleBorder(
            side: BorderSide(color: Theme.of(context).accentColor),
          ),
          padding: EdgeInsets.all(8.0),
          color: Theme.of(context).accentColor,
          child: Icon(
            MdiIcons.trophy,
            color: Theme.of(context).accentIconTheme.color,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => FunkyOverlay(_buildPage()),
            );
          },
        );

  static List<Widget> _buildPage() {
    return [
      Padding(
        padding: const EdgeInsets.all(100.0),
        child: Text("Ranking Here!"),
      ),
    ];
  }
}
