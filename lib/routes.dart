// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:school_web/screens/home_screen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          HomeScreen());
  static void setUpRouter() {
    router.define('/',
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
  }
}
