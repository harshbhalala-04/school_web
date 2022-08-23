// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/add_chapter_controller.dart';
import 'package:school_web/widgets/theme_button.dart';

class AddChapterCard extends StatefulWidget {
  const AddChapterCard({Key? key}) : super(key: key);

  @override
  State<AddChapterCard> createState() => _AddChapterCardState();
}

class _AddChapterCardState extends State<AddChapterCard> {
  final AddChapterController addChapterController =
      Get.put(AddChapterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container(
        width: 500,
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/add_class.svg",
                    width: 48,
                    height: 48,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add Chapter",
                    style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                    color: Colors.black38, width: 0.8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Obx(
                                  () => DropdownButton(
                                    underline: Container(),
                                    value:
                                        addChapterController.classValue.value,
                                    items:
                                        addChapterController.classList.map((e) {
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
                                      addChapterController
                                          .getSubjectList(val.toString(), false);
                                      addChapterController.classValue.value =
                                          val.toString();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => addChapterController.isSubjectVisible.value
                            ? Row(
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
                                  Expanded(
                                    child: Container(
                                      height: 40,
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
                                              .subjectValue.value,
                                          items: addChapterController
                                              .subjectList
                                              .map((e) {
                                            return DropdownMenuItem(
                                                value: e,
                                                child: e == ""
                                                    ? Text(
                                                        "Select Subject",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "calibri",
                                                            fontSize: 18,
                                                            color: Colors.grey),
                                                      )
                                                    : Text(e));
                                          }).toList(),
                                          onChanged: (val) {
                                            addChapterController.subjectValue
                                                .value = val.toString();
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : addChapterController.isLoading.value
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(() => !addChapterController.isChapterNumber.value
                          ? Container()
                          : Row(
                              children: [
                                Text(
                                  "Chapter No.",
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
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: TextFormField(
                                      onChanged: (val) {
                                        addChapterController
                                            .chapterNumber.value = val;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: Colors.black38,
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.all(8),
                                        hintText: "Chapter Number",
                                        hintStyle: TextStyle(
                                            fontFamily: "calibri",
                                            fontSize: 18,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => !addChapterController.isChapterName.value
                            ? Container()
                            : Row(
                                children: [
                                  Text(
                                    "Chapter Name.",
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
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      child: TextFormField(
                                        onChanged: (val) {
                                          addChapterController
                                              .chapterName.value = val;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          hintText: "Chapter Name",
                                          contentPadding: EdgeInsets.all(8),
                                          hintStyle: TextStyle(
                                              fontFamily: "calibri",
                                              fontSize: 18,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ThemeButton(text: "Add Chapter"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ThemeButton(text: "View Chapters"),
            ],
          ),
        ),
      ),
    );
  }
}
