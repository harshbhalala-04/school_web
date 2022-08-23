// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../theme.dart';

class DesktopAppBar extends StatefulWidget {
  const DesktopAppBar({Key? key}) : super(key: key);

  @override
  State<DesktopAppBar> createState() => _DesktopAppBarState();
}

class _DesktopAppBarState extends State<DesktopAppBar> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      leading: deviceSize.width < 768
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
      actions: deviceSize.width < 768
          ? []
          : [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Courses",
                        style: TextStyle(
                            fontFamily: "calibri",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text("Test Generator",
                          style: TextStyle(
                              fontFamily: "calibri",
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text("About us",
                          style: TextStyle(
                              fontFamily: "calibri",
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ThemeButton(text: "Login",),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
    );
  }
}
