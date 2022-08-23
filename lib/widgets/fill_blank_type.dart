// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/widgets/add_question_button.dart';
import 'package:school_web/widgets/image_upload_button.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../controller/edit_question_bank_controller.dart';
import '../utils/database.dart';

class FillBlankType extends StatefulWidget {
  bool forFillBlank;
  bool forTrueFalse;
  int typeNumber;
  FillBlankType(
      {this.forFillBlank = false,
      this.forTrueFalse = false,
      this.typeNumber = 0});

  @override
  State<FillBlankType> createState() => _FillBlankTypeState();
}

class _FillBlankTypeState extends State<FillBlankType> {
  TextEditingController fillBlankController = new TextEditingController();
  final ImagePickerController imgController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
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
              width: 900,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TextFormField(
                    controller: fillBlankController,
                    decoration: InputDecoration(
                      hintText: "Add Question Statement",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(203, 203, 203, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 25),
            Text(
              "OR",
              style: TextStyle(
                fontFamily: "calibri",
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Obx(
              () => imgController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage.value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl.value),
                        )
                      : ImageUploadButton(),
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
                if (fillBlankController.text.isEmpty) {
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

                DataBase().setFillBlankOrTrueFalseQue(
                    Get.find<EditQuestionBankController>().classValue.value,
                    Get.find<EditQuestionBankController>().subjectValue.value,
                    Get.find<EditQuestionBankController>().chapterValue.value,
                    chapterID,
                    fillBlankController.text,
                    widget.forFillBlank,
                    widget.forTrueFalse,
                    widget.typeNumber,
                    Get.find<ImagePickerController>().uploadedImageUrl.value);
                fillBlankController.clear();
                Get.find<ImagePickerController>().uploadedImageUrl.value = "";
                Get.find<ImagePickerController>().isUploadedImage.value = false;
                Get.find<ImagePickerController>().isLoading.value = false;
              },
              child: AddQuestionButton(),
            ),
          ],
        ),
      ],
    );
  }
}
