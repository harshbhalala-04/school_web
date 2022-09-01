// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/add_chapter_controller.dart';
import 'package:school_web/utils/database.dart';
import 'package:school_web/widgets/add_chapter_card.dart';

import '../theme.dart';

class ThemeButton extends StatefulWidget {
  final String text;
  ThemeButton({required this.text});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  AddChapterController addChapterController = Get.put(AddChapterController());
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
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.text == "View Chapters"
                ? [Colors.white, Colors.white]
                : buttonTheme,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
              fontFamily: "calibri",
              color:
                  widget.text == "View Chapters" ? Colors.blue : Colors.white,
              fontSize: 25.0),
        ),
      ),
    );
  }
}
