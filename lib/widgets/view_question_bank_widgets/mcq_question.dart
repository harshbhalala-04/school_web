// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/view_question_controller.dart';

class McqQuestion extends StatefulWidget {
  const McqQuestion({Key? key}) : super(key: key);

  @override
  State<McqQuestion> createState() => _McqQuestionState();
}

class _McqQuestionState extends State<McqQuestion> {
  final ViewQuestionBankController viewQuestionBankController =
      Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.mcqList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.mcqList[index]['questionImg'] == "" ||
                    viewQuestionBankController.mcqList[index]['questionImg'] ==
                        null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.mcqList[index]['questionImg'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.mcqList[index]['questionText']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                viewQuestionBankController.mcqList[index]['optionAImg'] == "" ||
                        viewQuestionBankController.mcqList[index]
                                ['optionAImg'] ==
                            null
                    ? Container()
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          viewQuestionBankController.mcqList[index]
                              ['optionAImg'],
                        ),
                      ),
                Row(
                  children: [
                    Text(
                      "a) ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      viewQuestionBankController.mcqList[index]['optionA'],
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                viewQuestionBankController.mcqList[index]['optionBImg'] == "" ||
                        viewQuestionBankController.mcqList[index]
                                ['optionBImg'] ==
                            null
                    ? Container()
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          viewQuestionBankController.mcqList[index]
                              ['optionBImg'],
                        ),
                      ),
                Row(
                  children: [
                    Text(
                      "b) ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      viewQuestionBankController.mcqList[index]['optionB'],
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                viewQuestionBankController.mcqList[index]['optionCImg'] == "" ||
                        viewQuestionBankController.mcqList[index]
                                ['optionCImg'] ==
                            null
                    ? Container()
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          viewQuestionBankController.mcqList[index]
                              ['optionCImg'],
                        ),
                      ),
                Row(
                  children: [
                    Text(
                      "c) ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      viewQuestionBankController.mcqList[index]['optionC'],
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                viewQuestionBankController.mcqList[index]['optionDImg'] == "" ||
                        viewQuestionBankController.mcqList[index]
                                ['optionDImg'] ==
                            null
                    ? Container()
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.network(
                          viewQuestionBankController.mcqList[index]
                              ['optionDImg'],
                        ),
                      ),
                Row(
                  children: [
                    Text(
                      "d) ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      viewQuestionBankController.mcqList[index]['optionD'],
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
