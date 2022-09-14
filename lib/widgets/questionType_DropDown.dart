import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/model/Question_model.dart';
import 'package:school_web/utils/questionsList.dart';

import '../controller/add_blueprint_controller.dart';
import '../model/question_type_model.dart';

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
    _value = '';
  }

  // @override
  // void didUpdateWidget(QuestionTypeDropDown oldWidget) {
  //   if (oldWidget.questions.questionType != widget.questions.questionType) {
  //     _value = widget.questions.questionType;
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

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
          value: addBlueprintController.questionTypeValue.value,
          items: questionsList.map((e) {
            return DropdownMenuItem(
                value: e.questionTxt,
                child: e.questionTxt == ""
                    ? const Text(
                        "Select Question Type",
                        style: TextStyle(
                            fontFamily: "calibri",
                            fontSize: 18,
                            color: Colors.grey),
                      )
                    : Text(e.questionTxt));
          }).toList(),
          onChanged: (value) {
            String questionType = '';
           Iterable<QuestionTypeModel> tempQuestionList =  questionsList.where((element) =>
              element.questionTxt == value
            );
           
            // print(value);
            // if (value == 'Choose Correct Answer') {
            //   questionType = 'type 1';
            // } else if (value == 'Fill in the blanks') {
            //   questionType = 'type 2';
            // } else if (value == 'True & False') {
            //   questionType = 'type 3';
            // } else if (value == 'Match the following') {
            //   questionType = 'type 4';
            // } else if (value == 'Subjective/One word QA/Very Short Answer') {
            //   questionType = 'type 5';
            // } else if (value == 'Subjective/Short Answer(2 marks)') {
            //   questionType = 'type 6';
            // } else if (value == 'Subjective Question(3 marks)') {
            //   questionType = 'type 7';
            // } else if (value == 'Subjective Question(4 marks)') {
            //   questionType = 'type 8';
            // } else if (value == 'Subjective Question(5 marks)') {
            //   questionType = 'type 9';
            // } else if (value == 'Case Base Question (MCQ Type)') {
            //   questionType = 'type 10';
            // } else if (value == 'Case Base Question (Short Answer)') {
            //   questionType = 'type 11';
            // } else if (value == 'Graph Question') {
            //   questionType = 'type 12';
            // } else if (value == 'Map Question') {
            //   questionType = 'type 13';
            // }
            setState(() {
              // _value = value.toString();
              addBlueprintController.questionTypeValue.value = value.toString();
              addBlueprintController
                  .questionSetList[widget.index].questionType = tempQuestionList.first.questionType;
              widget.questions.questionType = tempQuestionList.first.questionType.toString();
              addBlueprintController.isAddQuestionSet[widget.index] = true;
              addBlueprintController.update();
            });
          }),
    );
  }

  @override
  void dispose() {
    _value = '';
    super.dispose();
  }
}
