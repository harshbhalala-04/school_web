// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TestGeneratorScreen extends StatefulWidget {
  const TestGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<TestGeneratorScreen> createState() => _TestGeneratorScreenState();
}

class _TestGeneratorScreenState extends State<TestGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Center(child: Text("Test Generator Screen")),
    );
  }
}
