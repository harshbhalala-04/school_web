// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/edit_question_bank_controller.dart';
import '../controller/multiple_image_upload_controller.dart';
import '../utils/database.dart';
import 'add_question_button.dart';
import 'image_upload_button.dart';

class AddPictographType extends StatefulWidget {
  int typeNumber;
  AddPictographType({required this.typeNumber});

  @override
  State<AddPictographType> createState() => _AddPictographTypeState();
}

class _AddPictographTypeState extends State<AddPictographType> {
  final TextEditingController que1 = new TextEditingController();
  final TextEditingController que2 = new TextEditingController();
  final TextEditingController que3 = new TextEditingController();
  final TextEditingController que4 = new TextEditingController();

  final imgController = Get.put(MultipleImageUploadController());
  //final GlobalKey formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Add Pictograph",
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Question 1",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            QuestionField(
              hintText: "Enter Question",
              controller: que1,
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
          "Question 2",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            QuestionField(
              hintText: "Enter Question",
              controller: que2,
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
          "Question 3",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            QuestionField(
              hintText: "Enter Question",
              controller: que3,
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
          "Question 4",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            QuestionField(
              hintText: "Enter Question",
              controller: que4,
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
                              imgController.uploadedImageUrl[4].value))
                      : ImageUploadButton(
                          fromMultiple: true,
                          index: 3,
                        ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (que1.text.isEmpty ||
                    que2.text.isEmpty ||
                    que3.text.isEmpty ||
                    que4.text.isEmpty ||
                    imgController.uploadedImageUrl[0].value == "") {
                  Get.snackbar("Please Enter Values", "",
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }
                int idx = Get.find<EditQuestionBankController>()
                    .chaptersList
                    .indexOf(Get.find<EditQuestionBankController>()
                        .chapterValue
                        .value);
                String chapterID =
                    Get.find<EditQuestionBankController>().chaptersIdList[idx];
      //                String que1,
      // String que2,
      // String que3,
      // String que4,
      // String className,
      // String subjectName,
      // String chapterName,
      // String chapterID,
      // String paraImg,
      // String que1Img,
      // String que2Img,
      // String que3Img,
      // String que4Img,
      // int typeNumber
                DataBase().setPictographQue(
                  que1.text,
                  que2.text,
                  que3.text,
                  que4.text,
                  Get.find<EditQuestionBankController>().classValue.value,
                  Get.find<EditQuestionBankController>().subjectValue.value,
                  Get.find<EditQuestionBankController>().chapterValue.value,
                  chapterID,
                  imgController.uploadedImageUrl[0].value,
                  imgController.uploadedImageUrl[1].value,
                  imgController.uploadedImageUrl[2].value,
                  imgController.uploadedImageUrl[3].value,
                  imgController.uploadedImageUrl[4].value,
                  widget.typeNumber,
                );

                que1.clear();
                que2.clear();
                que3.clear();
                que4.clear();

                imgController.isLoading.value = [
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs
                ].obs;
                imgController.isUploadedImage.value = [
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs,
                  false.obs
                ].obs;
                imgController.uploadedImageUrl.value = [
                  "".obs,
                  "".obs,
                  "".obs,
                  "".obs,
                  "".obs,
                  "".obs,
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
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width > 1200 ? 900 : 500,
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
            // validator: (val) {
            //   if(val!.isEmpty) {
            //     return "Please enter value";
            //   }
            //   return null;
            // },
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
