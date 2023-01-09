// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/edit_question_bank_controller.dart';
import '../controller/image_picker_controller.dart';
import '../utils/database.dart';
import 'add_question_button.dart';
import 'image_upload_button.dart';

class MatchFollowing extends StatefulWidget {
  int typeNumber;
  MatchFollowing({required this.typeNumber});

  @override
  State<MatchFollowing> createState() => _MatchFollowingState();
}

class _MatchFollowingState extends State<MatchFollowing> {
  TextEditingController aController = new TextEditingController();
  TextEditingController bController = new TextEditingController();
  final ImagePickerController imgController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Question Statement",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Container(
              width: deviceSize.width > 1200 ? 450 : 250,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TextFormField(
                    maxLines: 1,
                    controller: aController,
                    decoration: InputDecoration(
                      hintText: "Add Part A",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(203, 203, 203, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              width: deviceSize.width > 1200 ? 450 : 250,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TextFormField(
                    maxLines: 1,
                    controller: bController,
                    decoration: InputDecoration(
                      hintText: "Add Part b",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(203, 203, 203, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (aController.text.isEmpty || bController.text.isEmpty) {
                  Get.snackbar("Please Enter value", "",
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.white);
                  return;
                }

                int idx = Get.find<EditQuestionBankController>()
                    .chaptersList
                    .indexOf(Get.find<EditQuestionBankController>()
                        .chapterValue
                        .value);
                String chapterID =
                    Get.find<EditQuestionBankController>().chaptersIdList[idx];
                print("This is id");
                print(chapterID);
                // DataBase().createNewCollection();
                DataBase().setMatchFollowingQue(
                  Get.find<EditQuestionBankController>().classValue.value,
                  Get.find<EditQuestionBankController>().subjectValue.value,
                  Get.find<EditQuestionBankController>().chapterValue.value,
                  chapterID,
                  aController.text,
                  bController.text,
                  widget.typeNumber,
                );
                aController.clear();
                bController.clear();
              },
              child: AddQuestionButton(),
            ),
          ],
        ),
      ],
    );
  }
}
