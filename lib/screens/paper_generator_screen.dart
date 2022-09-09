// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/TabScreen/select_blueprint.dart';
import 'package:school_web/widgets/TabScreen/test_paper_info.dart';

import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';

class PaperGeneratorScreen extends StatefulWidget {
  const PaperGeneratorScreen({super.key});

  @override
  State<PaperGeneratorScreen> createState() => _PaperGeneratorScreenState();
}

class _PaperGeneratorScreenState extends State<PaperGeneratorScreen> {
  bool isDataAvailable = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeColor),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: deviceSize.width > 768
              ? const PreferredSize(
                  child: DesktopAppBar(),
                  preferredSize: Size.fromHeight(70),
                )
              : AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                ),
          drawer: deviceSize.width > 768
              ? Container()
              : Drawer(
                  shape: const RoundedRectangleBorder(
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
              children: const [
                PaperGeneratorModel(),
                SizedBox(
                  height: 50,
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaperGeneratorModel extends StatefulWidget {
  const PaperGeneratorModel({super.key});

  @override
  State<PaperGeneratorModel> createState() => _PaperGeneratorModelState();
}

class _PaperGeneratorModelState extends State<PaperGeneratorModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Generate Paper",
          style: TextStyle(
              fontFamily: "calibri",
              letterSpacing: 3,
              fontSize: 100,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 50,
        ),
        TabBar(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 30),
          indicator: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10)),
          isScrollable: true,
          labelColor: const Color(0xff0893F8),
          labelPadding: const EdgeInsets.all(30),
          unselectedLabelColor: Colors.white,
          tabs: const [
            // Text(
            //   "Select\n Header",
            //   style: TextStyle(fontSize: 50),
            // ),
            Text(
              "Test paper\nInfo",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: "calibri",
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Select\n Blueprint",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: "calibri",
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        const SizedBox(
          height: 670,
          child: TabBarView(
            children: [TestpaperInfo(), SelectBlueprint()],
          ),
        )
      ],
    );
  }
}
