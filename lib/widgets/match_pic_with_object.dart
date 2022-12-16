// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/widgets/image_upload_button.dart';

import '../controller/edit_question_bank_controller.dart';
import '../controller/image_picker_controller.dart';
import '../utils/database.dart';
import 'add_question_button.dart';

class MatchPicWithObject extends StatefulWidget {
  int typeNumber;
  MatchPicWithObject({required this.typeNumber});

  @override
  State<MatchPicWithObject> createState() => _MatchPicWithObjectState();
}

class _MatchPicWithObjectState extends State<MatchPicWithObject> {
  TextEditingController bController = new TextEditingController();
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
            SizedBox(
              width: 25,
            ),
            Container(
              width: 450,
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
                if (!imgController.isUploadedImage.value ||
                    bController.text.isEmpty) {
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
                  Get.find<ImagePickerController>().uploadedImageUrl.value,
                  bController.text,
                  widget.typeNumber,
                );

                bController.clear();
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
