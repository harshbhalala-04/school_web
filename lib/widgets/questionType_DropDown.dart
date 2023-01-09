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
