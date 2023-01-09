// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/paper_generate_controller.dart';

import '../../theme.dart';

class SelectBlueprint extends StatefulWidget {
  const SelectBlueprint({Key? key}) : super(key: key);

  @override
  State<SelectBlueprint> createState() => _SelectBlueprintState();
}

class _SelectBlueprintState extends State<SelectBlueprint> {
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Card(
              margin: const EdgeInsets.only(left: 80, right: 80),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  // ignore: prefer_const_constructors
                  () => paperGenerateController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: paperGenerateController.blueprints.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          paperGenerateController
                                              .blueprints[index].blueprintName,
                                          style: TextStyle(
                                              fontFamily: "Calibri",
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 40,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: paperGenerateController
                                                .blueprints[index]
                                                .selectedChaptersName
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (context, selectedChapterIndex) {
                                              return SizedBox(
                                                width: 5,
                                              );
                                            },
                                            itemBuilder:
                                                (ctx, selectedChapterIndex) {
                                              return Text(
                                                paperGenerateController
                                                        .blueprints[index]
                                                        .selectedChaptersName[
                                                    selectedChapterIndex],
                                                style: TextStyle(
                                                    fontFamily: "Calibri",
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Questions: ${paperGenerateController.blueprints[index].totalQuestions}",
                                              style: TextStyle(
                                                  fontFamily: "Calibri",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Marks: ${paperGenerateController.blueprints[index].totalMarks}",
                                              style: TextStyle(
                                                  fontFamily: "Calibri",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/blueprint/${paperGenerateController.blueprints[index].blueprindId}", arguments: false);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 6.0, 10.0, 6.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: buttonTheme,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "View Blueprint",
                                          style: TextStyle(
                                              fontFamily: "calibri",
                                              color: Colors.white,
                                              fontSize: 25.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(paperGenerateController.isPaperGenerating.value) {
                                          return;
                                        }
                                        paperGenerateController.generatePaper(
                                            paperGenerateController
                                                .blueprints[index].blueprindId);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 6.0, 10.0, 6.0),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: buttonTheme,
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Use Blueprint",
                                          style: TextStyle(
                                              fontFamily: "calibri",
                                              color: Colors.white,
                                              fontSize: 25.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              )),
        ),
        Obx(() => paperGenerateController.isPaperGenerating.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container()),
      ],
    );
  }
}
