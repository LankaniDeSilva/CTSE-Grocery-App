import 'package:flutter/material.dart';

class UtilFunction {
//-----------------Navigator Function-----------------
  static void navigator(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
