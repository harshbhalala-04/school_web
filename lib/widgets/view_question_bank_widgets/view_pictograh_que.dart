// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class ViewPictographQue extends StatefulWidget {
  const ViewPictographQue({Key? key}) : super(key: key);

  @override
  State<ViewPictographQue> createState() => _ViewPictographQueState();
}

class _ViewPictographQueState extends State<ViewPictographQue> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    print(viewQuestionBankController.pictorgraphQueList);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.pictorgraphQueList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            viewQuestionBankController.pictorgraphQueList[index]['paraImg'] ==
                        "" ||
                    viewQuestionBankController.pictorgraphQueList[index]
                            ['paraImg'] ==
                        null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.pictorgraphQueList[index]
                          ['paraImg'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "1) ${viewQuestionBankController.pictorgraphQueList[index]['questions']['question1']}",
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
                    "2) ${viewQuestionBankController.pictorgraphQueList[index]['questions']['question2']}",
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
                    "3) ${viewQuestionBankController.pictorgraphQueList[index]['questions']['question3']}",
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
                    "4) ${viewQuestionBankController.pictorgraphQueList[index]['questions']['question4']}",
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
