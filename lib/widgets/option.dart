// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_web/theme.dart';

class Option extends StatefulWidget {
  final String imgPath;
  final String title;
  Option({required this.imgPath, required this.title});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
          colors: buttonTheme,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(widget.imgPath),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "calibri",
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
