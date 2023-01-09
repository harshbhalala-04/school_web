// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';

import '../../controller/view_question_controller.dart';
import '../../theme.dart';
import '../image_upload_button.dart';

class CaseBaseDesQue extends StatefulWidget {
  const CaseBaseDesQue({Key? key}) : super(key: key);

  @override
  State<CaseBaseDesQue> createState() => _CaseBaseDesQueState();
}

class _CaseBaseDesQueState extends State<CaseBaseDesQue> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  final ImagePickerController imgController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    print(viewQuestionBankController.caseBaseDesList);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.caseBaseDesList.length,
      itemBuilder: (ctx, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.caseBaseDesList[index]['paragraph']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            viewQuestionBankController.caseBaseDesList[index]['paraImg'] ==
                        "" ||
                    viewQuestionBankController.caseBaseDesList[index]
                            ['paraImg'] ==
                        null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.caseBaseDesList[index]
                          ['paraImg'],
                    ),
                  ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "1) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question1']}",
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
            Row(
              children: [
                Flexible(
                  child: Text(
                    "2) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question2']}",
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
            Row(
              children: [
                Flexible(
                  child: Text(
                    "3) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question3']}",
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
            Row(
              children: [
                Flexible(
                  child: Text(
                    "4) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question4']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "5) ${viewQuestionBankController.caseBaseDesList[index]['questions']['question5']}",
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
                                  if (imgController.isUploadedImage.value) {
                                    viewQuestionBankController
                                            .caseBaseDesList[index]['paraImg'] =
                                        imgController.uploadedImageUrl.value;
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
                                    "questionList": viewQuestionBankController
                                        .caseBaseDesList.value
                                  });
                                },
                                child: Text("Save"),
                              ),
                            ],
                            content: Container(
                              // height: 200,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Add Paragraph",
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
                                                            .caseBaseDesList[
                                                        index]['paragraph'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                          .caseBaseDesList[index]
                                                      ['paragraph'] = val;
                                                },
                                                // controller: fillBlankController,
                                                decoration: InputDecoration(
                                                  hintText: "Add Paragraph",
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
                                                  child: Image.network(
                                                      imgController
                                                          .uploadedImageUrl
                                                          .value),
                                                )
                                              : ImageUploadButton(),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question 1",
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
                                                                .caseBaseDesList[
                                                            index]['questions']
                                                        ['question1'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                              .caseBaseDesList[
                                                          index]['questions']
                                                      ['question1'] = val;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Add Question 1",
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
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question 2",
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
                                                                .caseBaseDesList[
                                                            index]['questions']
                                                        ['question2'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                              .caseBaseDesList[
                                                          index]['questions']
                                                      ['question2'] = val;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Add Question 2",
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
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question 3",
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
                                                                .caseBaseDesList[
                                                            index]['questions']
                                                        ['question3'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                              .caseBaseDesList[
                                                          index]['questions']
                                                      ['question3'] = val;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Add Question 3",
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
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question 4",
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
                                                                .caseBaseDesList[
                                                            index]['questions']
                                                        ['question4'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                              .caseBaseDesList[
                                                          index]['questions']
                                                      ['question4'] = val;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Add Question 4",
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
                                    ),SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Question 5",
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
                                                                .caseBaseDesList[
                                                            index]['questions']
                                                        ['question5'],
                                                onChanged: (val) {
                                                  viewQuestionBankController
                                                              .caseBaseDesList[
                                                          index]['questions']
                                                      ['question5'] = val;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: "Add Question 5",
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
                                  ],
                                ),
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
