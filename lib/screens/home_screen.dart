// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:school_web/screens/about_us_screen.dart';
import 'package:school_web/screens/auth_screen.dart';
import 'package:school_web/screens/test_generator_screen.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/about_us_section.dart';
import 'package:school_web/widgets/desktop_appbar.dart';
import 'package:school_web/widgets/option_card.dart';
import '../widgets/custom_tab.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeColor)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: deviceSize.width > 768
            ? PreferredSize(
                child: DesktopAppBar(),
                preferredSize: Size.fromHeight(70),
              )
            : AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
        drawer: deviceSize.width > 768
            ? Container()
            : Drawer(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: SideLayout(
                  pageIndex: 0,
                ),
              ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: deviceSize.width,
                height: deviceSize.height - deviceSize.height / 10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/hero.JPG"),
                  ),
                ),
              ),
              SizedBox(
                height: deviceSize.width > 1040 ? 50 : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "About us",
                    style: TextStyle(
                        fontFamily: "calibri",
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                ],
              ),
              AboutUsSection(),
              SizedBox(
                height: deviceSize.width > 1040 ? 50 : 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Features",
                    style: TextStyle(
                        fontFamily: "calibri",
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              OptionCard(),
              SizedBox(
                height: 50,
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
