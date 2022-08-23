// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/edit_question_bank_controller.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/controller/multiple_image_upload_controller.dart';
import 'package:school_web/widgets/case_base_des_type.dart';
import 'package:school_web/widgets/case_que_type.dart';
import 'package:school_web/widgets/fill_blank_type.dart';
import 'package:school_web/widgets/graph_type.dart';
import 'package:school_web/widgets/map_type.dart';
import 'package:school_web/widgets/mcq_type.dart';
import 'package:selectable/selectable.dart';

import '../theme.dart';
import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';

class EditQuestionBankScreen extends StatefulWidget {
  const EditQuestionBankScreen({Key? key}) : super(key: key);

  @override
  State<EditQuestionBankScreen> createState() => _EditQuestionBankScreenState();
}

class _EditQuestionBankScreenState extends State<EditQuestionBankScreen> {
  final EditQuestionBankController editQuestionBankController =
      Get.put(EditQuestionBankController());
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final MultipleImageUploadController multipleImgController =
      Get.put(MultipleImageUploadController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeColor)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: deviceSize.width > 768
            ? PreferredSize(
                child: DesktopAppBar(),
                preferredSize: Size.fromHeight(70),
              )
            : AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
        drawer: deviceSize.width > 768
            ? Container()
            : Drawer(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: SideLayout(
                  pageIndex: 0,
                ),
              ),
        body: SingleChildScrollView(
          child: Selectable(
            selectWordOnDoubleTap: true,
            // selectionColor: Colors.yellow.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 75.0, vertical: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    width: deviceSize.width,
                    padding: EdgeInsets.all(50),
                    child: Obx(
                      () => editQuestionBankController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Class ",
                                      style: TextStyle(
                                        fontFamily: "calibri",
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromRGBO(51, 51, 51, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.black38, width: 0.8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Obx(
                                          () => DropdownButton(
                                            underline: Container(),
                                            value: editQuestionBankController
                                                .classValue.value,
                                            items: editQuestionBankController
                                                .classList
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: e == ""
                                                      ? Text(
                                                          "Select Class",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "calibri",
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : Text(e));
                                            }).toList(),
                                            onChanged: (val) {
                                              editQuestionBankController
                                                  .classValue
                                                  .value = val.toString();
                                              editQuestionBankController
                                                  .getSubject(val.toString());
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Text(
                                        "Subject ",
                                        style: TextStyle(
                                          fontFamily: "calibri",
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.black38,
                                              width: 0.8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            hint: Text(
                                              "Select Subject",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            value: editQuestionBankController
                                                .subjectValue.value,
                                            items: editQuestionBankController
                                                .subjectList
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: e == ""
                                                      ? Text(
                                                          "Select Subject",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "calibri",
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : Text(e));
                                            }).toList(),
                                            onChanged: (val) {
                                              editQuestionBankController
                                                  .subjectValue
                                                  .value = val.toString();
                                              editQuestionBankController
                                                  .getChapters(
                                                      editQuestionBankController
                                                          .classValue.value,
                                                      val.toString());
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Text(
                                        "Chapter ",
                                        style: TextStyle(
                                          fontFamily: "calibri",
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.black38,
                                              width: 0.8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            hint: Text(
                                              "Select Chapter",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            value: editQuestionBankController
                                                .chapterValue.value,
                                            items: editQuestionBankController
                                                .chaptersList
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: e == ""
                                                      ? Text(
                                                          "Select Chapter",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "calibri",
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : Text(e));
                                            }).toList(),
                                            onChanged: (val) {
                                              editQuestionBankController
                                                  .chapterValue
                                                  .value = val.toString();
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      Text(
                                        "Question Type ",
                                        style: TextStyle(
                                          fontFamily: "calibri",
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(51, 51, 51, 1),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 40,
                                        //  width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                              color: Colors.black38,
                                              width: 0.8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            hint: Text(
                                              "Select Question Type",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            value: editQuestionBankController
                                                .questionTypeValue.value,
                                            items: editQuestionBankController
                                                .questionTypeList
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  value: e,
                                                  child: e == ""
                                                      ? Text(
                                                          "Select Question Type",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "calibri",
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : Text(e));
                                            }).toList(),
                                            onChanged: (val) {
                                              imagePickerController
                                                  .isUploadedImage
                                                  .value = false;
                                              imagePickerController
                                                  .uploadedImageUrl.value = "";
                                              editQuestionBankController
                                                  .questionTypeValue
                                                  .value = val.toString();
                                              editQuestionBankController
                                                      .questionSelectedIndex
                                                      .value =
                                                  editQuestionBankController
                                                      .questionTypeList
                                                      .indexOf(val.toString());

                                              if (editQuestionBankController
                                                      .questionSelectedIndex
                                                      .value ==
                                                  1 || editQuestionBankController
                                                      .questionSelectedIndex
                                                      .value ==
                                                  11) {
                                                multipleImgController
                                                    .isLoading.value = [
                                                  false.obs,
                                                  false.obs,
                                                  false.obs,
                                                  false.obs,
                                                  false.obs
                                                ].obs;
                                                multipleImgController
                                                    .isUploadedImage.value = [
                                                  false.obs,
                                                  false.obs,
                                                  false.obs,
                                                  false.obs,
                                                  false.obs
                                                ].obs;
                                                multipleImgController
                                                    .uploadedImageUrl.value = [
                                                  "".obs,
                                                  "".obs,
                                                  "".obs,
                                                  "".obs,
                                                  "".obs
                                                ];
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              1
                                          ? MCQType()
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              2
                                          ? FillBlankType(
                                              forFillBlank: true,
                                            )
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              3
                                          ? FillBlankType(
                                              forTrueFalse: true,
                                            )
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              4
                                          ? Text("Match the following")
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              5
                                          ? FillBlankType(typeNumber: 5)
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              6
                                          ? FillBlankType(typeNumber: 6)
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              7
                                          ? FillBlankType(typeNumber: 7)
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              8
                                          ? FillBlankType(typeNumber: 8)
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              9
                                          ? FillBlankType(typeNumber: 9)
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              10
                                          ? CaseQueType()
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              11
                                          ? CaseBaseDesType()
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              12
                                          ? GraphType()
                                          : Container(),
                                ),
                                Obx(
                                  () => editQuestionBankController
                                              .questionSelectedIndex.value ==
                                          0
                                      ? Container()
                                      : editQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              13
                                          ? MapType()
                                          : Container(),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
