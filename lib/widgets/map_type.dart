// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/widgets/add_question_button.dart';
import 'package:school_web/widgets/image_upload_button.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../controller/edit_question_bank_controller.dart';
import '../utils/database.dart';

class MapType extends StatefulWidget {
  const MapType({Key? key}) : super(key: key);

  @override
  State<MapType> createState() => _MapTypeState();
}

class _MapTypeState extends State<MapType> {
  final imgController = Get.put(ImagePickerController());
  final controller = new TextEditingController();
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
                controller: controller,
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
        SizedBox(height: 25),
        Text(
          "Upload Map Image",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
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
                      child:
                          Image.network(imgController.uploadedImageUrl.value),
                    )
                  : ImageUploadButton(),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (controller.text.isEmpty ||
                    !imgController.isUploadedImage.value) {
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
                    controller.text,
                    false,
                    false,
                    13,
                    Get.find<ImagePickerController>().uploadedImageUrl.value);
                controller.clear();
                Get.find<ImagePickerController>().isLoading.value = false;
                Get.find<ImagePickerController>().isUploadedImage.value = false;
                Get.find<ImagePickerController>().uploadedImageUrl.value = "";
              },
              child: AddQuestionButton(),
            ),
          ],
        ),
      ],
    );
  }
}
