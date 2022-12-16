// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/view_question_controller.dart';
import 'package:school_web/utils/questionsList.dart';
import 'package:school_web/widgets/match_following.dart';
import 'package:school_web/widgets/view_question_bank_widgets/case_base_des_que.dart';
import 'package:school_web/widgets/view_question_bank_widgets/case_base_mcq.dart';
import 'package:school_web/widgets/view_question_bank_widgets/descriptive_question.dart';
import 'package:school_web/widgets/view_question_bank_widgets/graph_que.dart';
import 'package:school_web/widgets/view_question_bank_widgets/map_que.dart';
import 'package:school_web/widgets/view_question_bank_widgets/mcq_question.dart';
import 'package:school_web/widgets/view_question_bank_widgets/view_pictograh_que.dart';

import '../theme.dart';
import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';
import '../widgets/theme_button.dart';
import '../widgets/view_question_bank_widgets/match_following_question.dart';
import '../widgets/view_question_bank_widgets/match_pic_with_object_question.dart';

class ViewQuestionBankScreen extends StatefulWidget {
  const ViewQuestionBankScreen({Key? key}) : super(key: key);

  @override
  State<ViewQuestionBankScreen> createState() => _ViewQuestionBankScreenState();
}

class _ViewQuestionBankScreenState extends State<ViewQuestionBankScreen> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  String selectedValue = "";
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeColor),
      ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                width: deviceSize.width,
                height: 363,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => viewQuestionBankController.isLoading.value
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
                                            value: viewQuestionBankController
                                                .classValue.value,
                                            items: viewQuestionBankController
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
                                              viewQuestionBankController
                                                  .classValue
                                                  .value = val.toString();
                                              viewQuestionBankController
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
                                            value: viewQuestionBankController
                                                .subjectValue.value,
                                            items: viewQuestionBankController
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
                                              viewQuestionBankController
                                                  .subjectValue
                                                  .value = val.toString();
                                              viewQuestionBankController
                                                  .getChapters(
                                                      viewQuestionBankController
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
                                            value: viewQuestionBankController
                                                .chapterValue.value,
                                            items: viewQuestionBankController
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
                                              viewQuestionBankController
                                                  .chapterValue
                                                  .value = val.toString();
                                            },
                                          ),
                                        ),
                                      ),
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
                                            value: viewQuestionBankController
                                                .questionTypeValue.value,
                                            items: questionsList.map((e) {
                                              return DropdownMenuItem(
                                                  value: e.questionTxt,
                                                  child: e.questionTxt == ""
                                                      ? Text(
                                                          "Select Question Type",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "calibri",
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      : Text(e.questionTxt));
                                            }).toList(),
                                            onChanged: (val) {
                                              viewQuestionBankController
                                                  .questionTypeValue
                                                  .value = val.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ThemeButton(
                                    text: "View questions",
                                    val: viewQuestionBankController
                                        .questionTypeValue.value),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceSize.width > 1040 ? 50 : 20,
              ),
              Padding(
                padding: deviceSize.width > 768
                    ? EdgeInsets.symmetric(horizontal: 75.0)
                    : EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: deviceSize.width,
                  child: Padding(
                    padding: deviceSize.width > 768
                        ? EdgeInsets.symmetric(horizontal: 50.0, vertical: 50)
                        : EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => !viewQuestionBankController.buttonPressed.value
                          ? Container()
                          : viewQuestionBankController.dataLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : viewQuestionBankController.questionSelectedIndex.value ==
                                      0
                                  ? Text("No records found")
                                  : viewQuestionBankController
                                              .questionSelectedIndex.value ==
                                          38
                                      ? viewQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              0
                                          ? Text("No records found")
                                          : ViewPictographQue()
                                      : viewQuestionBankController
                                                  .questionSelectedIndex
                                                  .value ==
                                              29
                                          ? viewQuestionBankController.mcqList.length ==
                                                  0
                                              ? Text("No records found")
                                              : McqQuestion()
                                          : viewQuestionBankController.questionSelectedIndex.value == 32 ||
                                                  viewQuestionBankController
                                                          .questionSelectedIndex
                                                          .value ==
                                                      74
                                              ? viewQuestionBankController
                                                          .matchFollowingList
                                                          .length ==
                                                      0
                                                  ? Text("No records found")
                                                  : MatchFollowingQuestion()
                                              : viewQuestionBankController
                                                          .questionSelectedIndex
                                                          .value ==
                                                      22
                                                  ? viewQuestionBankController
                                                              .matchObjWithTextList
                                                              .length ==
                                                          0
                                                      ? Text("No records found")
                                                      : MatchPicWithObjectQuestion()
                                                  : viewQuestionBankController.questionSelectedIndex.value == 81 ||
                                                          viewQuestionBankController
                                                                  .questionSelectedIndex
                                                                  .value ==
                                                              89 ||
                                                          viewQuestionBankController
                                                                  .questionSelectedIndex
                                                                  .value ==
                                                              90
                                                      ? CaseBaseMcq()
                                                      : viewQuestionBankController.questionSelectedIndex.value == 47 ||
                                                              viewQuestionBankController.questionSelectedIndex.value == 48 ||
                                                              viewQuestionBankController.questionSelectedIndex.value == 49 ||
                                                              viewQuestionBankController.questionSelectedIndex.value == 56 ||
                                                              viewQuestionBankController.questionSelectedIndex.value == 57
                                                          ? CaseBaseDesQue()
                                                          : ((viewQuestionBankController.questionSelectedIndex.value >= 1 && viewQuestionBankController.questionSelectedIndex.value <= 28) || (viewQuestionBankController.questionSelectedIndex.value >= 33 && viewQuestionBankController.questionSelectedIndex.value <= 60) || (viewQuestionBankController.questionSelectedIndex.value >= 62 && viewQuestionBankController.questionSelectedIndex.value <= 71) || (viewQuestionBankController.questionSelectedIndex.value >= 73 && viewQuestionBankController.questionSelectedIndex.value <= 94))
                                                              ? viewQuestionBankController.desList.length == 0
                                                                  ? Text("No records found")
                                                                  : DescriptiveQuestion()
                                                              : viewQuestionBankController.questionSelectedIndex.value == 61
                                                                  ? viewQuestionBankController.graphList.length == 0
                                                                      ? Text("No records found")
                                                                      : GraphQuestion()
                                                                  : viewQuestionBankController.questionSelectedIndex.value == 72
                                                                      ? viewQuestionBankController.mapList.length == 0
                                                                          ? Text("No records found")
                                                                          : MapQuestion()
                                                                      : Container(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
