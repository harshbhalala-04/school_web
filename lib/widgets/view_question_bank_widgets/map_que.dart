// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class MapQuestion extends StatefulWidget {
  const MapQuestion({Key? key}) : super(key: key);

  @override
  State<MapQuestion> createState() => _MapQuestionState();
}

class _MapQuestionState extends State<MapQuestion> {
 final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.mapList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.mapList[index]['imgUrl'] == "" ||
                    viewQuestionBankController.mapList[index]['imgUrl'] == null
                ? Container()
                : Container(
                    width: 400,
                    height: 400,
                    child: Image.network(
                      viewQuestionBankController.mapList[index]['imgUrl'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                     "${index + 1}) ${viewQuestionBankController.mapList[index]['questionText']}",
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