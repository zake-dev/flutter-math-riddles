import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/pages/my_page.dart';
import 'package:math_riddles/widget/funky_overlay.dart';

class MyRankButton extends Container {
  MyRankButton(context)
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
              MdiIcons.alphaM,
              size: 42,
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
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: MyPage(),
      ),
    ];
  }
}
