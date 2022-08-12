// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:school_web/widgets/option.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({Key? key}) : super(key: key);

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        width: deviceSize.width,
        height: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Option(
                imgPath: "assets/images/generate_paper.svg",
                title: "Generate \npaper",
              ),
              Option(
                imgPath: "assets/images/question_bank.svg",
                title: "Question \nbank",
              ),
              Option(
                imgPath: "assets/images/generate_paper.svg",
                title: "Add \nblueprint",
              ),
              Option(
                imgPath: "assets/images/add_class.svg",
                title: "Add \nclass",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
