import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/model/Question_model.dart';
import 'package:school_web/widgets/incDec.dart';
import 'package:school_web/widgets/questionType_DropDown.dart';

import '../controller/add_blueprint_controller.dart';

class QuestionSetWidget extends StatefulWidget {
  List<Questions> questions;
  int index;
  VoidCallback callback;
  List chaptersList;
  QuestionSetWidget(
      {Key? key,
      required this.questions,
      required this.index,
      required this.callback,
      required this.chaptersList})
      : super(key: key);

  @override
  _QuestionSetWidgetState createState() => _QuestionSetWidgetState();
}

class _QuestionSetWidgetState extends State<QuestionSetWidget> {
  
  @override
  Widget build(BuildContext context) {
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

    getMaximum(index) async {
     return await addBlueprintController.getQestionTypeMax(
                    addBlueprintController.classValue.value,
                    addBlueprintController.subjectValue.value,
                    widget.chaptersList[index],
                    addBlueprintController.questionSetList[index].itemName
                    );
    }

    // print(addBlueprintController.questionSet.toString());
    String selectedValue = '';
    return Card(
      child: Column(
        children: [
          const Text('Question Set A'),
          Row(
            children: const [
              Text('Question set Statement'),
              Flexible(
                child: TextField(),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Question Type'),
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
                            questions: addBlueprintController.questionSetList[widget.index]),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            (() => addBlueprintController.questionSetList.isNotEmpty ? 
             ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.chaptersList.length,
              itemBuilder: ((context, index) {
                // addBlueprintController.questionSetList.first.itemName == '' ?
                // addBlueprintController.questionSetList.first.itemName="type 1"
                // : addBlueprintController.update();
                
                
                NumberIncrementDecrementModel numberIncrementDecrementModel =
                    NumberIncrementDecrementModel(value: 0);
                return Row(
                  children: [
                    Text(chapterNameList[index]),
                    NumberIncrementDecrement(
                        numberIncrementDecrementModel:
                            numberIncrementDecrementModel),
                    FutureBuilder(
             future: getMaximum(index),
             builder: (context, snap){
              print(snap);
                if(snap.hasData){
                 return Text(snap.data.toString());
                }
                return SizedBox.shrink();
             }
                    )
                    // Text(addBlueprintController.maxSelectList[index]),
                  ],
                );
              }),
            ) : const SizedBox.shrink() 
          ),
          )
        ],
      ),
    );
  }
}
