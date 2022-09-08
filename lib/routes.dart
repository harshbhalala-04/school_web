// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:school_web/screens/add_blueprint.dart';
import 'package:school_web/screens/edit_question_bank_screen.dart';
import 'package:school_web/screens/home_screen.dart';
import 'package:school_web/screens/paper_generator_screen.dart';
import 'package:school_web/screens/view_chapter_screen.dart';
import 'package:school_web/screens/view_question_bank_screen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          HomeScreen());
  static Handler _viewChapterHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          ViewChapterScreen());
  static Handler _viewQuestionBankHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          ViewQuestionBankScreen());
  static Handler _editQuestionBankHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          EditQuestionBankScreen());
  static Handler _addBluePrintHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          AddBlueprintScreen());
  static Handler _papergeneratorHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          PaperGeneratorScreen());
  static void setUpRouter() {
    router.define('/',
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define('/view_chapters',
        handler: _viewChapterHandler, transitionType: TransitionType.fadeIn);
    router.define('/view-question-bank',
        handler: _viewQuestionBankHandler,
        transitionType: TransitionType.fadeIn);
    router.define('/edit-question-bank',
        handler: _editQuestionBankHandler,
        transitionType: TransitionType.fadeIn);
    router.define('/add-blueprint',
        handler: _addBluePrintHandler,
        transitionType: TransitionType.fadeIn);
    router.define('/paper_generator',
        handler: _papergeneratorHandler, transitionType: TransitionType.fadeIn);
  }
}
