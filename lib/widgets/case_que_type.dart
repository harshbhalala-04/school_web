// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/widgets/add_question_button.dart';
import 'package:school_web/widgets/image_upload_button.dart';
import 'package:school_web/widgets/mcq_type.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../controller/edit_question_bank_controller.dart';
import '../utils/database.dart';

class CaseQueType extends StatefulWidget {
  const CaseQueType({Key? key}) : super(key: key);

  @override
  State<CaseQueType> createState() => _CaseQueTypeState();
}

final TextEditingController paragraphController = new TextEditingController();
List<Map<String, dynamic>> questionMap = [{}, {}, {}, {}];

class _CaseQueTypeState extends State<CaseQueType> {
  // final TextEditingController que = new TextEditingController();
  final imgController = Get.put(ImagePickerController());
  final para = new TextEditingController();
  final que1 = new TextEditingController();
  final q1OptA = new TextEditingController();
  final q1OptB = new TextEditingController();
  final q1OptC = new TextEditingController();
  final q1OptD = new TextEditingController();
  final que2 = new TextEditingController();
  final que3 = new TextEditingController();
  final que4 = new TextEditingController();
  final q2OptA = new TextEditingController();
  final q2OptB = new TextEditingController();
  final q2OptC = new TextEditingController();
  final q2OptD = new TextEditingController();
  final q3OptA = new TextEditingController();
  final q3OptB = new TextEditingController();
  final q3OptC = new TextEditingController();
  final q3OptD = new TextEditingController();
  final q4OptA = new TextEditingController();
  final q4OptB = new TextEditingController();
  final q4OptC = new TextEditingController();
  final q4OptD = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Add Paragraph",
          style: TextStyle(
            fontFamily: "calibri",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        QuestionField(
          hintText: "Add Paragraph",
          isPara: true,
          controller: para,
          questionIndex: -1,
          optionNumber: "NA",
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OR",
              style: TextStyle(
                fontFamily: "calibri",
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageUploadButton(),
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
              questionIndex: 0,
              controller: que1,
              optionNumber: "question",
            ),
            // SizedBox(width: 25),
            // Text(
            //   "OR",
            //   style: TextStyle(
            //     fontFamily: "calibri",
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   width: 25,
            // ),
            // ImageUploadButton(),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option A",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option A",
                questionIndex: 0,
                controller: q1OptA,
                optionNumber: "optionA",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option B",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option B",
                questionIndex: 0,
                controller: q1OptB,
                optionNumber: "optionB",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option C",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option C",
                questionIndex: 0,
                controller: q1OptC,
                optionNumber: "optionC",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option D",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option D",
                questionIndex: 0,
                controller: q1OptD,
                optionNumber: "optionD",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
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
              questionIndex: 1,
              controller: que2,
              optionNumber: "question",
            ),
            // SizedBox(width: 25),
            // Text(
            //   "OR",
            //   style: TextStyle(
            //     fontFamily: "calibri",
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   width: 25,
            // ),
            // ImageUploadButton(),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option A",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option A",
                questionIndex: 1,
                controller: q2OptA,
                optionNumber: "optionA",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option B",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option B",
                questionIndex: 1,
                controller: q2OptB,
                optionNumber: "optionB",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option C",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option C",
                questionIndex: 1,
                controller: q2OptC,
                optionNumber: "optionC",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option D",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option D",
                questionIndex: 1,
                optionNumber: "optionD",
                controller: q2OptD,
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
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
              questionIndex: 2,
              controller: que3,
              optionNumber: "question",
            ),
            // SizedBox(width: 25),
            // Text(
            //   "OR",
            //   style: TextStyle(
            //     fontFamily: "calibri",
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   width: 25,
            // ),
            // ImageUploadButton(),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option A",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option A",
                questionIndex: 2,
                controller: q3OptA,
                optionNumber: "optionA",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option B",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option B",
                questionIndex: 2,
                controller: q3OptB,
                optionNumber: "optionB",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option C",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option C",
                questionIndex: 2,
                controller: q3OptC,
                optionNumber: "optionC",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option D",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option D",
                questionIndex: 2,
                controller: q3OptD,
                optionNumber: "optionD",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
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
              questionIndex: 3,
              controller: que4,
              optionNumber: "question",
            ),
            // SizedBox(width: 25),
            // Text(
            //   "OR",
            //   style: TextStyle(
            //     fontFamily: "calibri",
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   width: 25,
            // ),
            // ImageUploadButton(),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option A",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option A",
                questionIndex: 3,
                controller: q4OptA,
                optionNumber: "optionA",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option B",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option B",
                questionIndex: 3,
                controller: q4OptB,
                optionNumber: "optionB",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option C",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option C",
                questionIndex: 3,
                controller: q4OptC,
                optionNumber: "optionC",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Add Option D",
            style: TextStyle(
              fontFamily: "calibri",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              QuestionField(
                hintText: "Add Option D",
                questionIndex: 3,
                controller: q4OptD,
                optionNumber: "optionD",
              ),
              // SizedBox(width: 25),
              // Text(
              //   "OR",
              //   style: TextStyle(
              //     fontFamily: "calibri",
              //     fontSize: 20,
              //   ),
              // ),
              // SizedBox(
              //   width: 25,
              // ),
              // ImageUploadButton(),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (para.text.isEmpty ||
                    que1.text.isEmpty ||
                    que2.text.isEmpty ||
                    que3.text.isEmpty ||
                    que4.text.isEmpty ||
                    q1OptA.text.isEmpty ||
                    q2OptA.text.isEmpty ||
                    q3OptA.text.isEmpty ||
                    q4OptA.text.isEmpty ||
                    q1OptB.text.isEmpty ||
                    q2OptB.text.isEmpty ||
                    q3OptB.text.isEmpty ||
                    q4OptB.text.isEmpty ||
                    q1OptC.text.isEmpty ||
                    q2OptC.text.isEmpty ||
                    q3OptC.text.isEmpty ||
                    q4OptC.text.isEmpty ||
                    q1OptD.text.isEmpty ||
                    q2OptD.text.isEmpty ||
                    q3OptD.text.isEmpty ||
                    q4OptD.text.isEmpty) {
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
                DataBase().setCaseBaseMcq(
                  questionMap,
                  paragraphController.text,
                  Get.find<EditQuestionBankController>().classValue.value,
                  Get.find<EditQuestionBankController>().subjectValue.value,
                  Get.find<EditQuestionBankController>().chapterValue.value,
                  chapterID,
                  imgController.uploadedImageUrl.value,
                );
                para.clear();
                que1.clear();
                que2.clear();
                que3.clear();
                que4.clear();
                q1OptA.clear();
                q1OptB.clear();
                q1OptC.clear();
                q1OptD.clear();
                q2OptA.clear();
                q2OptB.clear();
                q2OptC.clear();
                q2OptD.clear();
                q3OptA.clear();
                q3OptB.clear();
                q3OptC.clear();
                q3OptD.clear();
                for (int i = 0; i < 4; i++) {
                  questionMap[i]['question'] = "";
                  questionMap[i]['optionA'] = "";
                  questionMap[i]['optionB'] = "";
                  questionMap[i]['optionC'] = "";
                  questionMap[i]['optionD'] = "";
                  questionMap[i]['option'] = "";
                }
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
  final int questionIndex;
  final String optionNumber;
  final TextEditingController controller;
  bool isPara;
  QuestionField(
      {required this.hintText,
      required this.questionIndex,
      required this.optionNumber,
      this.isPara = false,
      required this.controller});
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
            onChanged: (val) {
              if (isPara) {
                paragraphController.text = val;
              } else {
                questionMap[questionIndex][optionNumber] = val;
              }
            },
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
