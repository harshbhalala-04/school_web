import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/model/Question_model.dart';

import '../controller/add_blueprint_controller.dart';

class QuestionTypeDropDown extends StatefulWidget {
  QuestionSetModel questions;
  int index;

  QuestionTypeDropDown({required this.questions, required this.index});
  @override
  _QuestionTypeDropDownState createState() => _QuestionTypeDropDownState();
}

class _QuestionTypeDropDownState extends State<QuestionTypeDropDown> {
  String _value = "";
    final AddBlueprintController addBlueprintController =
        Get.put(AddBlueprintController());
  @override
  void initState() {
    super.initState();
    _value = widget.questions.questionType;
  }

  @override
  void didUpdateWidget(QuestionTypeDropDown oldWidget) {
    if (oldWidget.questions.questionType != widget.questions.questionType) {
      _value = widget.questions.questionType;
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
          underline: SizedBox(),
          value: _value,
          items: questionTypeList.map((e) {
            return DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  e,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              value: e,
            );
          }).toList(),
          onChanged: (value) {
            String questionType = '';
            if (value == 'Choose Correct Answer') {
              questionType = 'type 1';
            } else if (value == 'Fill in the blanks') {
              questionType = 'type 2';
            } else if (value == 'True & False') {
              questionType = 'type 3';
            } else if (value == 'Match the following') {
              questionType = 'type 4';
            } else if (value == 'Subjective/One word QA/Very Short Answer') {
              questionType = 'type 5';
            } else if (value == 'Subjective/Short Answer(2 marks)') {
              questionType = 'type 6';
            } else if (value == 'Subjective Question(3 marks)') {
              questionType = 'type 7';
            } else if (value == 'Subjective Question(4 marks)') {
              questionType = 'type 8';
            } else if (value == 'Subjective Question(5 marks)') {
              questionType = 'type 9';
            } else if (value == 'Case Base Question (MCQ Type)') {
              questionType = 'type 10';
            } else if (value == 'Case Base Question (Short Answer)') {
              questionType = 'type 11';
            } else if (value == 'Graph Question') {
              questionType = 'type 12';
            } else if (value == 'Map Question') {
              questionType = 'type 13';
            }
            setState(() {
              _value = value.toString();
              addBlueprintController.questionSetList[widget.index].questionType = questionType;
              widget.questions.questionType = questionType.toString();
              addBlueprintController.isAddQuestionSet[widget.index] = true;
              addBlueprintController.update();
            });
          }),
    );
  }
}
