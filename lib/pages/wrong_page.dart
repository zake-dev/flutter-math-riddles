import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:math_riddles/utils/size_config.dart';

class WrongPage extends Container {
  WrongPage(context, hint, workout)
      : super(
          child: Column(
            children: [
              Text(
                'Wrong!',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.safeBlockHorizontal * 7,
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              Icon(MdiIcons.alertCircle,
                  size: SizeConfig.safeBlockHorizontal * 15),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Text(
                'Do you need some help?',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Monserrat',
                  fontWeight: FontWeight.w300,
                  fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: SizeConfig.safeBlockHorizontal * 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Hint',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: SizeConfig.safeBlockHorizontal * 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        );
}
