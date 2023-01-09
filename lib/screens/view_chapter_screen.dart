// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/add_chapter_controller.dart';
import 'package:school_web/widgets/add_chapter_card.dart';
import 'package:school_web/widgets/theme_button.dart';

import '../theme.dart';
import '../widgets/desktop_appbar.dart';
import '../widgets/footer.dart';
import '../widgets/side_layout.dart';

class ViewChapterScreen extends StatefulWidget {
  const ViewChapterScreen({Key? key}) : super(key: key);

  @override
  State<ViewChapterScreen> createState() => _ViewChapterScreenState();
}

class _ViewChapterScreenState extends State<ViewChapterScreen> {
  bool isDataAvailable = true;
  AddChapterController addChapterController = Get.put(AddChapterController());
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
                                value: addChapterController
                                    .viewChapterClassValue.value,
                                items: addChapterController.classList.map((e) {
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
                                  addChapterController.getSubjectList(
                                      val.toString(), true);
                                  addChapterController.viewChapterClassValue
                                      .value = val.toString();
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
                      () => !addChapterController
                              .viewChapterSubjectVisible.value
                          ? addChapterController.isLoading.value
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
                                      value: addChapterController
                                          .viewChapterSubjectValue.value,
                                      items: addChapterController
                                          .viewChapterSubjectList
                                          .map((e) {
                                        print("E val: ${e}");
                                        print(
                                            "Sub val:  ${addChapterController.viewChapterSubjectValue}");
                                        print(
                                            "List val:  ${addChapterController.viewChapterSubjectList}");

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
                                        addChapterController
                                            .viewChapterSubjectValue
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
                    InkWell(
                      onTap: () {
                        addChapterController.getChapterName(
                            addChapterController.viewChapterClassValue.value,
                            addChapterController.viewChapterSubjectValue.value);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: buttonTheme,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "View Chapters",
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
              SizedBox(
                height: deviceSize.width > 1040 ? 50 : 20,
              ),
              Padding(
                padding: deviceSize.width > 768
                    ? EdgeInsets.symmetric(horizontal: 75.0)
                    : EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: deviceSize.width,
                  child: Padding(
                    padding: deviceSize.width > 768
                        ? EdgeInsets.symmetric(horizontal: 50.0, vertical: 50)
                        : EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => addChapterController.chapterLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : addChapterController.chaptersList.value.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No Record found"),
                                  ],
                                )
                              : Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7),
                                  },
                                  // children: addChapterController
                                  //     .chaptersList.value.entries
                                  //     .map(
                                  //   (e) {

                                  //     return buildRow([e.key, e.value]);
                                  //   },
                                  // ).toList(),
                                  children: addChapterController
                                      .chaptersList.value.entries
                                      .map(
                                    (e) {
                                      return buildRow([e.key, e.value]);
                                    },
                                  ).toList(),
                                ),
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

  TableRow buildRow(List<String> cells, {isHeader = false}) {
    return TableRow(
      children: cells
          .map((cell) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    cell,
                    style: TextStyle(
                      fontWeight:
                          cell == "Chapter No." || cell == "Chapter Name"
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
