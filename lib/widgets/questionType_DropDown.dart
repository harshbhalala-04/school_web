import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/model/Question_model.dart';

import '../controller/add_blueprint_controller.dart';

class QuestionTypeDropDown extends StatefulWidget {
  Questions questions;

  QuestionTypeDropDown({required this.questions});
  @override
  _QuestionTypeDropDownState createState() => _QuestionTypeDropDownState();
}

class _QuestionTypeDropDownState extends State<QuestionTypeDropDown> {
  String _value = "";
  @override
  void initState() {
    super.initState();
    _value = widget.questions.itemName;
  }

  @override
  void didUpdateWidget(QuestionTypeDropDown oldWidget) {
    if (oldWidget.questions.itemName != widget.questions.itemName) {
      _value = widget.questions.itemName;
    }
    super.didUpdateWidget(oldWidget);
  }

  List questionTypeList = [
    "",
    "Choose Correct Answer",
    "Fill in the blanks",
    "True & False",
    "Match the following",
    "Subjective/One word QA/Very Short Answer",
    "Subjective/Short Answer(2 marks)",
    "Subjective Question(3 marks)",
    "Subjective Question(4 marks)",
    "Subjective Question(5 marks)",
    "Case Base Question (MCQ Type)",
    "Case Base Question (Short Answer)",
    "Graph Question",
    "Map Question",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
          value: _value,
          items: questionTypeList.map((e) {
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          }).toList(),
          onChanged: (value) {
             String questionType = '';
             if(value == 'Choose Correct Answer') {
        questionType = 'type 1';
      } else if (value=='Fill in the blanks') {
        questionType = 'type 2';
      }else if(value =='True & False') {
        questionType = 'type 3';
      }else if(value == 'Match the following') {
        questionType = 'type 4';
      }else if(value == 'Subjective/One word QA/Very Short Answer') {
        questionType = 'type 5';
      }else if(value == 'Subjective/Short Answer(2 marks)') {
        questionType = 'type 6';
      }else if(value == 'Subjective Question(3 marks)') {
        questionType = 'type 7';
      }else if(value == 'Subjective Question(4 marks)') {
        questionType = 'type 8';
      }else if(value == 'Subjective Question(5 marks)') {
        questionType = 'type 9';
      }else if(value == 'Case Base Question (MCQ Type)') {
        questionType = 'type 10';
      }else if(value == 'Case Base Question (Short Answer)') {
        questionType = 'type 11';
      }else if(value == 'Graph Question') {
        questionType = 'type 12';
      }else if(value == 'Map Question') {
        questionType = 'type 13';
      }
            setState(() {
              _value = value.toString();
              widget.questions.itemName = questionType.toString();
            });
          }),
    );
  }
}