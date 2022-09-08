import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/model/Question_model.dart';
import 'package:school_web/widgets/incDec.dart';
import 'package:school_web/widgets/questionType_DropDown.dart';

import '../controller/add_blueprint_controller.dart';

class QuestionSetWidget extends StatefulWidget {
  List<QuestionSetModel> questions;
  int index;
  VoidCallback callback;
  List chaptersList;
  String charset;

  QuestionSetWidget(
      {Key? key,
      required this.questions,
      required this.index,
      required this.callback,
      required this.chaptersList,
      required this.charset})
      : super(key: key);

  @override
  _QuestionSetWidgetState createState() => _QuestionSetWidgetState();
}

class _QuestionSetWidgetState extends State<QuestionSetWidget> {
  final questionStatementController = TextEditingController();

  @override
  void dispose() {
  // Clean up the controller when the Widget is disposed
  questionStatementController.dispose(); 
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    final textstyle = const TextStyle(
        fontFamily: "calibri", fontSize: 25, color: Colors.black);
      
    List chapterNameList = [];
    final AddBlueprintController addBlueprintController =
        Get.put(AddBlueprintController());
    for (var element1 in widget.chaptersList) {
      for (var element2 in addBlueprintController.chapters) {
        if (element2.id == element1) {
          chapterNameList.add(element2.name);
        }
      }
    }

    getMaximum(index,type ) async {
      return await addBlueprintController.getQestionTypeMax(
          addBlueprintController.classValue.value,
          addBlueprintController.subjectValue.value,
          widget.chaptersList[index],
          type);
    }

    String selectedValue = '';
    String questionset = "A";

    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Question Set ${widget.charset}',
              style: textstyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Question set\n Statement',
                    style: textstyle,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                   Flexible(
                    child: TextField(
                      controller: questionStatementController,
                      onChanged: (value) {
                        addBlueprintController.questionSetList[widget.index].questionStatement = value;
                      },

                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Question Type',
                    style: textstyle,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 40,
                    //  width: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.black38, width: 0.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Obx(
                        () => QuestionTypeDropDown(
                          index: widget.index,
                            questions: addBlueprintController
                                .questionSetList[widget.index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
              
              Obx(  
                (() => addBlueprintController.isAddQuestionSet[widget.index] == true
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.chaptersList.length,
                        itemBuilder: ((context, index) {
                          NumberIncrementDecrementModel
                              numberIncrementDecrementModel =
                              NumberIncrementDecrementModel(value: 0,index: widget.index, chapterId: widget.chaptersList[index].toString(),chapterIndex: index );
                              NumberIncrementDecrement numberIncrementDecrement =NumberIncrementDecrement(numberIncrementDecrementModel: numberIncrementDecrementModel,);
                          return Row(
                            children: [
                              Text(
                                chapterNameList[index].toString().toUpperCase(),
                                style: textstyle,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              NumberIncrementDecrement(
                                  numberIncrementDecrementModel:
                                      numberIncrementDecrementModel),
                              // const SizedBox(
                              //   width: 50,
                              // ),
                              Obx(
                                ()=> 
                                addBlueprintController.questionSetList[widget.index].questionType != '' ?
                                FutureBuilder(
                                    future: getMaximum(index,addBlueprintController.questionSetList[widget.index].questionType),
                                    builder: (context, snap) {
                                     
                                      if (snap.hasData) {
                                        return Text(
                                         'Availble : ${snap.data}',
                                          style: const TextStyle(
                                            fontFamily: "calibri", fontSize: 25, color: Colors.red
                                          ),
                                        );
                                      }
                                      if(snap.data == null) {
                                        const Text(
                                         'Data not Availble',
                                          style: TextStyle(
                                            fontFamily: "calibri", fontSize: 25, color: Colors.red
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }) : const  SizedBox.shrink()
                              )
                              // Text(addBlueprintController.maxSelectList[index]),
                            ],
                          );
                        }),
                      )
                    : const  SizedBox.shrink())
              ),
            )
          ],
        ),
      ),
    );
  }
}
