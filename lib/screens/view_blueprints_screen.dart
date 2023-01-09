// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/view_blueprint_controller.dart';
import 'package:school_web/theme.dart';

import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';
import '../widgets/theme_button.dart';

class ViewBlueprintsScreen extends StatefulWidget {
  const ViewBlueprintsScreen({Key? key}) : super(key: key);

  @override
  State<ViewBlueprintsScreen> createState() => _ViewBlueprintsScreenState();
}

class _ViewBlueprintsScreenState extends State<ViewBlueprintsScreen> {
  final ViewBlueprintController viewBlueprintController =
      Get.put(ViewBlueprintController());
  @override
  Widget build(BuildContext context) {
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
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Class ",
                          style: TextStyle(
                            fontFamily: "calibri",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border:
                                Border.all(color: Colors.black38, width: 0.8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Obx(
                              () => DropdownButton(
                                underline: Container(),
                                value: viewBlueprintController.classValue.value,
                                items:
                                    viewBlueprintController.classList.map((e) {
                                  return DropdownMenuItem(
                                      value: e,
                                      child: e == ""
                                          ? Text(
                                              "Select Class",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            )
                                          : Text(e));
                                }).toList(),
                                onChanged: (val) {
                                  viewBlueprintController.getSubjectList(
                                      val.toString(), true);
                                  viewBlueprintController.classValue.value =
                                      val.toString();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => !viewBlueprintController.isSubjectVisible.value
                          ? viewBlueprintController.isLoading.value
                              ? CircularProgressIndicator()
                              : Container()
                          : Row(
                              children: [
                                Text(
                                  "Subject ",
                                  style: TextStyle(
                                    fontFamily: "calibri",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                        color: Colors.black38, width: 0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: DropdownButton(
                                      underline: Container(),
                                      hint: Text(
                                        "Select Subject",
                                        style: TextStyle(
                                            fontFamily: "calibri",
                                            fontSize: 18,
                                            color: Colors.grey),
                                      ),
                                      value: viewBlueprintController
                                          .subjectValue.value,
                                      items: viewBlueprintController.subjectList
                                          .map((e) {
                                        return DropdownMenuItem(
                                            value: e,
                                            child: e == ""
                                                ? Text(
                                                    "Select Subject",
                                                    style: TextStyle(
                                                        fontFamily: "calibri",
                                                        fontSize: 18,
                                                        color: Colors.grey),
                                                  )
                                                : Text(e));
                                      }).toList(),
                                      onChanged: (val) {
                                        viewBlueprintController.subjectValue
                                            .value = val.toString();
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ThemeButton(text: "View Blueprints"),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Card(
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
                    () => viewBlueprintController.isBlueprintLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                viewBlueprintController.blueprints.length,
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
                                            viewBlueprintController
                                                .blueprints[index]
                                                .blueprintName,
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
                                              itemCount: viewBlueprintController
                                                  .blueprints[index]
                                                  .selectedChaptersName
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder: (context,
                                                  selectedChapterIndex) {
                                                return SizedBox(
                                                  width: 5,
                                                );
                                              },
                                              itemBuilder:
                                                  (ctx, selectedChapterIndex) {
                                                return Text(
                                                  viewBlueprintController
                                                          .blueprints[index]
                                                          .selectedChaptersName[
                                                      selectedChapterIndex],
                                                  style: TextStyle(
                                                      fontFamily: "Calibri",
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                "Questions: ${viewBlueprintController.blueprints[index].totalQuestions}",
                                                style: TextStyle(
                                                    fontFamily: "Calibri",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Marks: ${viewBlueprintController.blueprints[index].totalMarks}",
                                                style: TextStyle(
                                                    fontFamily: "Calibri",
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          print("here clicked");
                                          Get.toNamed("/blueprint/${viewBlueprintController.blueprints[index].blueprindId}", arguments: true);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 6.0, 10.0, 6.0),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: buttonTheme,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
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
