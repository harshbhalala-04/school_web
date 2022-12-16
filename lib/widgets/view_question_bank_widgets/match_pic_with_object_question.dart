// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class MatchPicWithObjectQuestion extends StatefulWidget {
  const MatchPicWithObjectQuestion({Key? key}) : super(key: key);

  @override
  State<MatchPicWithObjectQuestion> createState() =>
      _MatchPicWithObjectQuestionState();
}

class _MatchPicWithObjectQuestionState
    extends State<MatchPicWithObjectQuestion> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.matchObjWithTextList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.matchObjWithTextList[index]['imgUrl'] == "" ||
                    viewQuestionBankController.matchObjWithTextList[index]['imgUrl'] == null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.matchObjWithTextList[index]['imgUrl'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.matchObjWithTextList[index]['partB']}",
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
