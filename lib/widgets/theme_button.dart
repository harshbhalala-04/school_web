// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/add_chapter_controller.dart';
import 'package:school_web/controller/view_question_controller.dart';
import 'package:school_web/utils/database.dart';
import 'package:school_web/widgets/add_chapter_card.dart';

import '../theme.dart';

class ThemeButton extends StatefulWidget {
  final String text;
  String val;
  ThemeButton({required this.text, this.val = ""});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  AddChapterController addChapterController = Get.put(AddChapterController());
  ViewQuestionBankController viewQuestionBankController =
      Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.text == "Add Chapter") {
          Get.back();
          DataBase().addChapterToSubject(
              addChapterController.classValue.value,
              addChapterController.subjectValue.value,
              addChapterController.chapterNumber.value,
              addChapterController.chapterName.value);
        } else if (widget.text == "View Chapters") {
          Get.toNamed('/view_chapters');
        } else if (widget.text == "View chapters") {
          addChapterController.getChapterName(
              addChapterController.viewChapterClassValue.value,
              addChapterController.viewChapterSubjectValue.value);
        } else if (widget.text == "View questions") {
          print(widget.val);
          viewQuestionBankController.questionSelectedIndex.value =
              viewQuestionBankController.questionTypeList
                  .indexOf(widget.val.toString());
          int idx = viewQuestionBankController.chaptersList
              .indexOf(viewQuestionBankController.chapterValue.value);
          String chapterID = viewQuestionBankController.chaptersIdList[idx];
          viewQuestionBankController.fetchData(chapterID);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: buttonTheme,
          ),
          borderRadius: BorderRadius.circular(27),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontFamily: "calibri", color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
  }
}
