// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../theme.dart';

class AddQuestionButton extends StatefulWidget {
  const AddQuestionButton({Key? key}) : super(key: key);

  @override
  State<AddQuestionButton> createState() => _AddQuestionButtonState();
}

class _AddQuestionButtonState extends State<AddQuestionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: buttonTheme,
        ),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Text(
        "Add Question",
        style: TextStyle(
            fontFamily: "calibri", color: Colors.white, fontSize: 20.0),
      ),
    );
  }
}
