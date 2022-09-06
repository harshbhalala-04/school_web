import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NumberIncrementDecrement extends StatefulWidget {
  final NumberIncrementDecrementModel numberIncrementDecrementModel;
 
  NumberIncrementDecrement({ required this.numberIncrementDecrementModel});
  @override
  State<NumberIncrementDecrement> createState() => _NumberIncrementDecrementState(numberIncrementDecrementModel: numberIncrementDecrementModel);
 
}
 
class _NumberIncrementDecrementState extends State<NumberIncrementDecrement> {
 
  TextEditingController controller = TextEditingController();
  final NumberIncrementDecrementModel numberIncrementDecrementModel;
 
  _NumberIncrementDecrementState({
    required this.numberIncrementDecrementModel,
  });
 
  @override
  void initState() {
    super.initState();
    controller.addListener(onChange);
    
  }
 
  void onChange() {
    this.numberIncrementDecrementModel.value=int.parse(controller.text.replaceAll("Adet", "").trim());
  }
  @override
  Widget build(BuildContext context) {
    int i = 0;
    i++;
    print(i.toString());
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 25,
            height: 48,
            child: GestureDetector(
              onTap: () => minus(),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: new Radius.circular(5),
                          bottomLeft: new Radius.circular(5)),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Icon(Icons.remove, color: Colors.black)),
            )),
        SizedBox(
          width: 80,
          height: 50,
          child: TextField(
            autofocus: false,
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              hintText: this.numberIncrementDecrementModel.value.toString(),
              hintStyle: TextStyle(color: Colors.black),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
                borderSide: const BorderSide(color: Colors.white, width: 2.0),
              ),
            ),
          ),
        ),
        SizedBox(
            width: 25,
            height: 48,
            child: GestureDetector(
              onTap: () => add(),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: new Radius.circular(5),
                          bottomRight: new Radius.circular(5)),
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Icon(Icons.add, color: Colors.black)),
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
      if (this.numberIncrementDecrementModel.value != 0) this.numberIncrementDecrementModel.value--;
      controller.text = this.numberIncrementDecrementModel.value.toString();
    });
   }
}

class NumberIncrementDecrementModel {
    int value;
  NumberIncrementDecrementModel({
    required this.value,
  });

  NumberIncrementDecrementModel copyWith({
    int? value,
  }) {
    return NumberIncrementDecrementModel(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory NumberIncrementDecrementModel.fromMap(Map<String, dynamic> map) {
    return NumberIncrementDecrementModel(
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NumberIncrementDecrementModel.fromJson(String source) => NumberIncrementDecrementModel.fromMap(json.decode(source));

  @override
  String toString() => 'NumberIncrementDecrementModel(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NumberIncrementDecrementModel &&
      other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
