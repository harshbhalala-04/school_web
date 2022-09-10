// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class GraphQuestion extends StatefulWidget {
  const GraphQuestion({Key? key}) : super(key: key);

  @override
  State<GraphQuestion> createState() => _GraphQuestionState();
}

class _GraphQuestionState extends State<GraphQuestion> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.graphList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.graphList[index]['imgUrl'] == "" ||
                    viewQuestionBankController.graphList[index]['imgUrl'] ==
                        null
                ? Container()
                : Container(
                    width: 400,
                    height: 400,
                    child: Image.network(
                      viewQuestionBankController.graphList[index]['imgUrl'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.graphList[index]['questionText']}",
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
