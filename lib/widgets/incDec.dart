import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/controller/add_blueprint_controller.dart';

class NumberIncrementDecrement extends StatefulWidget {
  final NumberIncrementDecrementModel numberIncrementDecrementModel;

  NumberIncrementDecrement({required this.numberIncrementDecrementModel});

  @override
  State<NumberIncrementDecrement> createState() =>
      _NumberIncrementDecrementState(
          numberIncrementDecrementModel: numberIncrementDecrementModel);
}

class _NumberIncrementDecrementState extends State<NumberIncrementDecrement> {
  TextEditingController controller = TextEditingController();
  final NumberIncrementDecrementModel numberIncrementDecrementModel;
  final AddBlueprintController addBlueprintController =
      Get.put(AddBlueprintController());

  _NumberIncrementDecrementState({
    required this.numberIncrementDecrementModel,
  });

  @override
  void initState() {
    super.initState();
     addBlueprintController.questionSetList[numberIncrementDecrementModel.index].chapterWithRequiredQues!.add({
        numberIncrementDecrementModel.chapterId: '0'
      });
    controller.addListener(onChange);
     
  }

  void onChange() {
    this.numberIncrementDecrementModel.value =
        int.parse(controller.text.replaceAll("Adet", "").trim());
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    i++;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 25,
            height: 48,
            child: GestureDetector(
              onTap: () {
                minus();
                currentValue();
              },
              child: Container(
                child: Transform.rotate(
                  angle: 180 * math.pi / 180,
                  child: const IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: null,
                  ),
                ),
              ),
            )),
        SizedBox(
          width: 80,
          height: 50,
          child: TextField(
            autofocus: false,
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 22),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                hintText: numberIncrementDecrementModel.value.toString(),
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
        SizedBox(
            width: 25,
            height: 48,
            child: GestureDetector(
              onTap: () {
                add();
                currentValue();
              },
              child: const Icon(
                Icons.play_arrow,
                color: Colors.blue,
                size: 30,
              ),
            )),
      ],
    );
  }

  void add() {
    setState(() {
      this.numberIncrementDecrementModel.value++;
      controller.text = this.numberIncrementDecrementModel.value.toString();
    });
  }

  void minus() {
    setState(() {
      if (this.numberIncrementDecrementModel.value != 0)
        this.numberIncrementDecrementModel.value--;
      controller.text = this.numberIncrementDecrementModel.value.toString();
    });
  }

  currentValue() {
    setState(() {
      controller.text;
    });
    addBlueprintController.update();
 addBlueprintController.questionSetList[numberIncrementDecrementModel.index]
    .chapterWithRequiredQues!.elementAt(numberIncrementDecrementModel.chapterIndex).update(
      numberIncrementDecrementModel.chapterId,(value) => controller.text,ifAbsent: () => controller.text);
  }
}

class NumberIncrementDecrementModel {
  int value;
  int index;
  String chapterId;
  int chapterIndex;
  NumberIncrementDecrementModel({
    required this.value,
    required this.index,
    required this.chapterId,
    required this.chapterIndex
  });
}
