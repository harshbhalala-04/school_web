// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/paper_generate_controller.dart';
import 'package:school_web/controller/view_blueprint_controller.dart';
import 'package:school_web/model/blueprint_model.dart';

import '../theme.dart';
import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';

class SingleBlueprintScreen extends StatefulWidget {
  final String id;
  SingleBlueprintScreen({required this.id});

  @override
  State<SingleBlueprintScreen> createState() => _SingleBlueprintScreenState();
}

class _SingleBlueprintScreenState extends State<SingleBlueprintScreen> {
  final ViewBlueprintController viewBlueprintController =
      Get.put(ViewBlueprintController());
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());
  @override
  void initState() {
    // TODO: implement initState
    viewBlueprintController.isSingleBlueprintLoad.toggle();

    viewBlueprintController.isSingleBlueprintLoad.toggle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build of single blueprint screen");
    final fromViewBlueprint = Get.arguments as bool;
    late BluePrint bluePrint;
    print(fromViewBlueprint);
    int idx = -1;
    if (fromViewBlueprint) {
      idx = viewBlueprintController.blueprints
          .indexWhere((element) => element.blueprindId == widget.id);
    } else {
      idx = paperGenerateController.blueprints
          .indexWhere((element) => element.blueprindId == widget.id);
      print(idx);
    }

    // print(viewBlueprintController.blueprints[idx].blueprindId);
    if (fromViewBlueprint) {
      bluePrint = BluePrint(
        className: viewBlueprintController.blueprints[idx].className,
        subjectName: viewBlueprintController.blueprints[idx].subjectName,
        questionSet: viewBlueprintController.blueprints[idx].questionSet,
        blueprintName: viewBlueprintController.blueprints[idx].blueprintName,
        totalMarks: viewBlueprintController.blueprints[idx].totalMarks,
        totalQuestions: viewBlueprintController.blueprints[idx].totalQuestions,
        selectedChaptersName:
            viewBlueprintController.blueprints[idx].selectedChaptersName,
        blueprindId: viewBlueprintController.blueprints[idx].blueprindId,
      );
    } else {
      bluePrint = BluePrint(
        className: paperGenerateController.blueprints[idx].className,
        subjectName: paperGenerateController.blueprints[idx].subjectName,
        questionSet: paperGenerateController.blueprints[idx].questionSet,
        blueprintName: paperGenerateController.blueprints[idx].blueprintName,
        totalMarks: paperGenerateController.blueprints[idx].totalMarks,
        totalQuestions: paperGenerateController.blueprints[idx].totalQuestions,
        selectedChaptersName:
            paperGenerateController.blueprints[idx].selectedChaptersName,
        blueprindId: paperGenerateController.blueprints[idx].blueprindId,
      );
    }

    print(bluePrint.blueprindId);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeColor),
      ),
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                width: deviceSize.width,
                // height: 250,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Obx(
                  () => viewBlueprintController.isSingleBlueprintLoad.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              bluePrint.blueprintName,
                              style: TextStyle(
                                  fontFamily: "Calibri",
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Class: ${bluePrint.className}",
                              style: TextStyle(
                                fontFamily: "Calibri",
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Subject: ${bluePrint.subjectName}",
                              style: TextStyle(
                                fontFamily: "Calibri",
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chapters: ",
                                  style: TextStyle(
                                      fontFamily: "Calibri",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                                Container(
                                  height: 40,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        bluePrint.selectedChaptersName.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder:
                                        (context, selectedChapterIndex) {
                                      return SizedBox(
                                        width: 5,
                                      );
                                    },
                                    itemBuilder: (ctx, selectedChapterIndex) {
                                      return Text(
                                        bluePrint.selectedChaptersName[
                                            selectedChapterIndex],
                                        style: TextStyle(
                                            fontFamily: "Calibri",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total Questions: ${bluePrint.totalQuestions}",
                                  style: TextStyle(
                                      fontFamily: "Calibri",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Total Marks: ${bluePrint.totalMarks}",
                                  style: TextStyle(
                                      fontFamily: "Calibri",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bluePrint.questionSet.length,
                              itemBuilder: (ctx, index) {
                                Map<String, dynamic> myMap = bluePrint
                                    .questionSet[index]['RequiredQuestion'];
                                myMap.forEach((key, value) {
                                  print(key);
                                  print(value);
                                });
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1}. ${bluePrint.questionSet[index]['QuestionStatement']}",
                                      style: TextStyle(
                                          fontFamily: "Calibri",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: myMap.length,
                                      itemBuilder: (_, idx) {
                                        String key = myMap.keys.elementAt(idx);
                                        return Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            "${key.substring(0, key.length - 23)} : ${myMap[key]}",
                                            style: TextStyle(
                                              fontFamily: "Calibri",
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // bluePrint.questionSet[index]['RequiredQuestion'].entries.map((entry) {
                                    //   return Text(entry.key);
                                    // }).toList(),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
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
