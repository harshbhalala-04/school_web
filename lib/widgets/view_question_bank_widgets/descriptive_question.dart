// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/controller/view_question_controller.dart';

import '../../theme.dart';
import '../image_upload_button.dart';

class DescriptiveQuestion extends StatefulWidget {
  const DescriptiveQuestion({Key? key}) : super(key: key);

  @override
  State<DescriptiveQuestion> createState() => _DescriptiveQuestionState();
}

class _DescriptiveQuestionState extends State<DescriptiveQuestion> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  final TextEditingController editingController = new TextEditingController();
  final ImagePickerController imgController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.desList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            viewQuestionBankController.desList[index]['imgUrl'] == "" ||
                    viewQuestionBankController.desList[index]['imgUrl'] == null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.desList[index]['imgUrl'],
                    ),
                  ),
            Obx(() => Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${index + 1}) ${viewQuestionBankController.desList[index]['questionText']}",
                        style: TextStyle(
                          fontFamily: "calibri",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if(imgController.isUploadedImage.value) {
                                    viewQuestionBankController.desList[index]['imgUrl'] = imgController.uploadedImageUrl.value;
                                  }
                                  setState(() {});
                                  int ind = viewQuestionBankController
                                      .chaptersList
                                      .indexWhere((element) =>
                                          element ==
                                          viewQuestionBankController
                                              .chapterValue.value);
                                  String chapterId = viewQuestionBankController
                                      .chaptersIdList[ind];
                                  FirebaseFirestore.instance
                                      .collection("question_bank")
                                      .doc(viewQuestionBankController
                                          .classValue.value)
                                      .collection(viewQuestionBankController
                                          .subjectValue.value)
                                      .doc(chapterId)
                                      .collection("questions")
                                      .doc(
                                          "type ${viewQuestionBankController.questionSelectedIndex.value}")
                                      .update({
                                    "questionList":
                                        viewQuestionBankController.desList.value
                                  });
                                },
                                child: Text("Save"),
                              ),
                            ],
                            content: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Question Statement",
                                        style: TextStyle(
                                          fontFamily: "calibri",
                                          fontSize: 28,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 450,
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          color: Colors.white,
                                          child: Container(
                                            padding: EdgeInsets.only(left: 12),
                                            child: TextFormField(
                                              maxLines: 10,
                                              initialValue:
                                                  viewQuestionBankController
                                                          .desList[index]
                                                      ['questionText'],
                                              onChanged: (val) {
                                                viewQuestionBankController
                                                        .desList[index]
                                                    ['questionText'] = val;
                                              },
                                              // controller: fillBlankController,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Add Question Statement",
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      203, 203, 203, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
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
                                                child: Image.network(imgController
                                                    .uploadedImageUrl.value),
                                              )
                                            : ImageUploadButton(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: buttonTheme,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Edit Question",
                      style: TextStyle(
                          fontFamily: "calibri",
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  setState(() {});
                                  final deletedQue = viewQuestionBankController
                                      .desList
                                      .removeAt(index);
                                  final deletedQueList = [];
                                  deletedQueList.add(deletedQue);
                                  int ind = viewQuestionBankController
                                      .chaptersList
                                      .indexWhere((element) =>
                                          element ==
                                          viewQuestionBankController
                                              .chapterValue.value);
                                  String chapterId = viewQuestionBankController
                                      .chaptersIdList[ind];
                                  FirebaseFirestore.instance
                                      .collection("question_bank")
                                      .doc(viewQuestionBankController
                                          .classValue.value)
                                      .collection(viewQuestionBankController
                                          .subjectValue.value)
                                      .doc(chapterId)
                                      .collection("questions")
                                      .doc(
                                          "type ${viewQuestionBankController.questionSelectedIndex.value}")
                                      .update({
                                    "questionList":
                                        FieldValue.arrayRemove(deletedQueList)
                                  });
                                  FirebaseFirestore.instance
                                      .collection("question_bank")
                                      .doc(viewQuestionBankController
                                          .classValue.value)
                                      .collection(viewQuestionBankController
                                          .subjectValue.value)
                                      .doc(chapterId)
                                      .get()
                                      .then((val) {
                                    int newValue = val.data()![
                                            "type ${viewQuestionBankController.questionSelectedIndex.value}"] -
                                        1;
                                    FirebaseFirestore.instance
                                        .collection("question_bank")
                                        .doc(viewQuestionBankController
                                            .classValue.value)
                                        .collection(viewQuestionBankController
                                            .subjectValue.value)
                                        .doc(chapterId)
                                        .update({
                                      "type ${viewQuestionBankController.questionSelectedIndex.value}":
                                          newValue
                                    });
                                  });
                                },
                                child: Text("Yes"),
                              ),
                            ],
                            content: Text("Do you want to delete?"),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: buttonTheme,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Delete Question",
                      style: TextStyle(
                          fontFamily: "calibri",
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                  ),
                ),
              ],
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
