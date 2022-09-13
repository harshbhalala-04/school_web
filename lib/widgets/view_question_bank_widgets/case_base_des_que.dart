// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class CaseBaseDesQue extends StatefulWidget {
  const CaseBaseDesQue({Key? key}) : super(key: key);

  @override
  State<CaseBaseDesQue> createState() => _CaseBaseDesQueState();
}

class _CaseBaseDesQueState extends State<CaseBaseDesQue> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    print(viewQuestionBankController.caseBaseDesList);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.caseBaseDesList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.caseBaseDesList[index]['paragraph']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            viewQuestionBankController.caseBaseDesList[index]['paraImg'] ==
                        "" ||
                    viewQuestionBankController.caseBaseDesList[index]
                            ['paraImg'] ==
                        null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.caseBaseDesList[index]
                          ['paraImg'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "1) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question1']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "2) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question2']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "3) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question3']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "4) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question4']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
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
