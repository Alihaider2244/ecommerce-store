import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();

  Future<dynamic> PushAndReplace(  Widget widget, BuildContext context) {
    return Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctr) => widget));
  }

  Future<dynamic> Push(Widget widget, BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctr) => widget));
  }
}
