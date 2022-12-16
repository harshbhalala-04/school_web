// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/view_question_controller.dart';

class CaseBaseMcq extends StatefulWidget {
  const CaseBaseMcq({Key? key}) : super(key: key);

  @override
  State<CaseBaseMcq> createState() => _CaseBaseMcqState();
}

class _CaseBaseMcqState extends State<CaseBaseMcq> {
  final viewQuestionBankController = Get.put(ViewQuestionBankController());
  @override
  Widget build(BuildContext context) {
    print(viewQuestionBankController.caseBaseMcqList);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewQuestionBankController.caseBaseMcqList.length,
      itemBuilder: (ctx, index) {
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    "${index + 1}) ${viewQuestionBankController.caseBaseMcqList[index]['paragraph']}",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            viewQuestionBankController.caseBaseMcqList[index]['paraImg'] ==
                        "" ||
                    viewQuestionBankController.caseBaseMcqList[index]
                            ['paraImg'] ==
                        null
                ? Container()
                : Container(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      viewQuestionBankController.caseBaseMcqList[index]
                          ['paraImg'],
                    ),
                  ),
            buildQuestions(
              srNo: "1",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 0,
              keyVal: "question",
            ),
            buildQuestions(
              srNo: "a",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 0,
              keyVal: "optionA",
            ),
            buildQuestions(
              srNo: "b",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 0,
              keyVal: "optionB",
            ),
            buildQuestions(
              srNo: "c",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 0,
              keyVal: "optionC",
            ),
            buildQuestions(
              srNo: "d",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 0,
              keyVal: "optionD",
            ),
            buildQuestions(
              srNo: "2",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 1,
              keyVal: "question",
            ),
            buildQuestions(
              srNo: "a",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 1,
              keyVal: "optionA",
            ),
            buildQuestions(
              srNo: "b",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 1,
              keyVal: "optionB",
            ),
            buildQuestions(
              srNo: "c",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 1,
              keyVal: "optionC",
            ),
            buildQuestions(
              srNo: "d",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 1,
              keyVal: "optionD",
            ),
            buildQuestions(
              srNo: "3",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 2,
              keyVal: "question",
            ),
            buildQuestions(
              srNo: "a",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 2,
              keyVal: "optionA",
            ),
            buildQuestions(
              srNo: "b",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 2,
              keyVal: "optionB",
            ),
            buildQuestions(
              srNo: "c",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 2,
              keyVal: "optionC",
            ),
            buildQuestions(
              srNo: "d",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 2,
              keyVal: "optionD",
            ),
            buildQuestions(
              srNo: "4",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 3,
              keyVal: "question",
            ),
            buildQuestions(
              srNo: "a",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 3,
              keyVal: "optionA",
            ),
            buildQuestions(
              srNo: "b",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 3,
              keyVal: "optionB",
            ),
            buildQuestions(
              srNo: "c",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 3,
              keyVal: "optionC",
            ),
            buildQuestions(
              srNo: "d",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 3,
              keyVal: "optionD",
            ),
            buildQuestions(
              srNo: "5",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 4,
              keyVal: "question",
            ),
            buildQuestions(
              srNo: "a",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 4,
              keyVal: "optionA",
            ),
            buildQuestions(
              srNo: "b",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 4,
              keyVal: "optionB",
            ),
            buildQuestions(
              srNo: "c",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 4,
              keyVal: "optionC",
            ),
            buildQuestions(
              srNo: "d",
              viewQuestionBankController: viewQuestionBankController,
              index: index,
              queNo: 4,
              keyVal: "optionD",
            ),
            SizedBox(
              height: 10,
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

class buildQuestions extends StatelessWidget {
  const buildQuestions({
    Key? key,
    required this.srNo,
    required this.viewQuestionBankController,
    required this.index,
    required this.queNo,
    required this.keyVal,
  }) : super(key: key);

  final ViewQuestionBankController viewQuestionBankController;
  final int index;
  final String srNo;
  final int queNo;
  final String keyVal;

  @override
  Widget build(BuildContext context) {
   
    
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              "$srNo) ${viewQuestionBankController.caseBaseMcqList[index]['questions'][queNo][keyVal] ?? "" }",
              style: TextStyle(
                fontFamily: "calibri",
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
