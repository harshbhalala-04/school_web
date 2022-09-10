// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/view_question_controller.dart';

class DescriptiveQuestion extends StatefulWidget {
  const DescriptiveQuestion({Key? key}) : super(key: key);

  @override
  State<DescriptiveQuestion> createState() => _DescriptiveQuestionState();
}

class _DescriptiveQuestionState extends State<DescriptiveQuestion> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.desList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.desList[index]['imgUrl'] == "" ||
                    viewQuestionBankController.desList[index]['imgUrl'] == null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.desList[index]['imgUrl'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                     "${index + 1}) ${viewQuestionBankController.desList[index]['questionText']}",
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
