// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:school_web/widgets/option.dart';

class QuestionBankDialoge extends StatefulWidget {
  const QuestionBankDialoge({Key? key}) : super(key: key);

  @override
  State<QuestionBankDialoge> createState() => _QuestionBankDialogeState();
}

class _QuestionBankDialogeState extends State<QuestionBankDialoge> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container(
        height: 350,
        child: Column(
          children: [
            Text(
              "Question Bank",
              style: TextStyle(
                fontFamily: "calibri",
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Option(
                        imgPath: "assets/images/question_bank.svg",
                        title: "View\n Question Bank"),
                    SizedBox(width: 25),
                    Option(
                        imgPath: "assets/images/question_bank.svg",
                        title: "Edit\n Question Bank")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
