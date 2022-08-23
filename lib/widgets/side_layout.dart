// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:school_web/widgets/sidebar_item.dart';

class SideLayout extends StatefulWidget {
  final int pageIndex;

  SideLayout({required this.pageIndex});

  @override
  State<SideLayout> createState() => _SideLayoutState();
}

class _SideLayoutState extends State<SideLayout> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: 500,
      child: Column(
        children: [
          SizedBox(height: 70),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 56,
                height: 56,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SideBarItem(
            title: "Home",
            isSelected: widget.pageIndex == 0,
          ),
          SideBarItem(
            title: "Course",
            isSelected: widget.pageIndex == 1,
          ),
          SideBarItem(
            title: "Test Generator",
            isSelected: widget.pageIndex == 2,
          ),
          SideBarItem(
            title: "About US",
            isSelected: widget.pageIndex == 3,
          ),
          SideBarItem(title: "Login", isSelected: widget.pageIndex == 4),
        ],
      ),
    );
  }
}
