import 'package:flutter/cupertino.dart';

class SizeConfig {
  //---------get the screen height
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  //---------get the screen width
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
}
