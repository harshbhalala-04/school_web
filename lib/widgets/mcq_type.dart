// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/edit_question_bank_controller.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/controller/multiple_image_upload_controller.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/add_question_button.dart';
import 'package:school_web/widgets/image_upload_button.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../utils/database.dart';

class MCQType extends StatefulWidget {
  const MCQType({Key? key}) : super(key: key);

  @override
  State<MCQType> createState() => _MCQTypeState();
}

class _MCQTypeState extends State<MCQType> {
  final TextEditingController queController = new TextEditingController();
  final TextEditingController optionA = new TextEditingController();
  final TextEditingController optionB = new TextEditingController();
  final TextEditingController optionC = new TextEditingController();
  final TextEditingController optionD = new TextEditingController();
  final MultipleImageUploadController imgController =
      Get.put(MultipleImageUploadController());
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
            QuestionField(
                hintText: "Add Question Statement", controller: queController),
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
              () => imgController.isLoading[0].value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage[0].value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl[0].value))
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 0,
                        ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Add Option A",
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
            QuestionField(
              hintText: "Add option A",
              controller: optionA,
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
              () => imgController.isLoading[1].value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage[1].value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl[1].value))
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 1,
                        ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Add Option B",
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
            QuestionField(
              hintText: "Add Option B",
              controller: optionB,
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
              () => imgController.isLoading[2].value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage[2].value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl[2].value))
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 2,
                        ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Add Option C",
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
            QuestionField(
              hintText: "Add Option C",
              controller: optionC,
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
              () => imgController.isLoading[3].value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage[3].value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl[3].value))
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 3,
                        ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Add Option D",
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
            QuestionField(
              hintText: "Add Option D",
              controller: optionD,
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
              () => imgController.isLoading[4].value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : imgController.isUploadedImage[4].value
                      ? Container(
                          height: 300,
                          width: 300,
                          child: Image.network(
                              imgController.uploadedImageUrl[4].value),
                        )
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 4,
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
                if (queController.text.isEmpty ||
                    optionA.text.isEmpty ||
                    optionB.text.isEmpty ||
                    optionC.text.isEmpty ||
                    optionD.text.isEmpty) {
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
                DataBase().setMcqQuestion(
                  Get.find<EditQuestionBankController>().classValue.value,
                  Get.find<EditQuestionBankController>().subjectValue.value,
                  Get.find<EditQuestionBankController>().chapterValue.value,
                  chapterID,
                  queController.text,
                  optionA.text,
                  optionB.text,
                  optionC.text,
                  optionD.text,
                  imgController.uploadedImageUrl[0].value,
                  imgController.uploadedImageUrl[1].value,
                  imgController.uploadedImageUrl[2].value,
                  imgController.uploadedImageUrl[3].value,
                  imgController.uploadedImageUrl[4].value,
                );
                queController.clear();
                optionA.clear();
                optionB.clear();
                optionC.clear();
                optionD.clear();
                imgController.isLoading.value =
                    [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
                imgController.isUploadedImage.value =
                    [false.obs, false.obs, false.obs, false.obs, false.obs].obs;
                imgController.uploadedImageUrl.value = [
                  "".obs,
                  "".obs,
                  "".obs,
                  "".obs,
                  "".obs
                ];
                
              },
              child: AddQuestionButton(),
            ),
          ],
        ),
      ],
    );
  }
}

class QuestionField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  bool isPara;
  QuestionField(
      {required this.hintText, required this.controller, this.isPara = false});
  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: controller,
            maxLines: isPara ? 5 : 1,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color.fromRGBO(203, 203, 203, 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
