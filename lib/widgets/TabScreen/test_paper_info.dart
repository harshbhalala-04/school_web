import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/paper_generate_controller.dart';

import '../../controller/add_chapter_controller.dart';

class TestpaperInfo extends StatefulWidget {
  // const TestpaperInfo({super.key , controller}){tabva};

  @override
  State<TestpaperInfo> createState() => _TestpaperInfoState();
  TestpaperInfo({Key? key, controller}) : super(key: key) {
    tabController = controller;
  }
}

late TabController tabController;

class _TestpaperInfoState extends State<TestpaperInfo> {
  final AddChapterController addChapterController =
      Get.put(AddChapterController());
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.only(left: 80, right: 80),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Test Paper Name",
                        style: TextStyle(
                          fontFamily: "calibri",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(51, 51, 51, 1),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: TextFormField(
                      onChanged: (value) {
                        paperGenerateController.testPaperName.value =
                            value.toString();
                      },
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Test paper name here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(),
                        ),
                      ),),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Class ",
                      style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(color: Colors.black38, width: 0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Obx(
                            () => DropdownButton(
                              underline: Container(),
                              value: addChapterController.classValue.value,
                              items: addChapterController.classList.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: e == ""
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              "Select Class",
                                              style: TextStyle(
                                                  fontFamily: "calibri",
                                                  fontSize: 18,
                                                  color: Colors.grey[800]),
                                            ),
                                          )
                                        : Text(e));
                              }).toList(),
                              onChanged: (val) {
                                addChapterController.getSubjectList(
                                    val.toString(), false);
                                paperGenerateController.className.value =
                                    val.toString();
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
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => addChapterController.isSubjectVisible.value
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Subject ",
                              style: TextStyle(
                                fontFamily: "calibri",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                      color: Colors.black38, width: 0.8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: DropdownButton(
                                    underline: Container(),
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "Select Subject",
                                        style: TextStyle(
                                            fontFamily: "calibri",
                                            fontSize: 18,
                                            color: Colors.grey[800]),
                                      ),
                                    ),
                                    value:
                                        addChapterController.subjectValue.value,
                                    items: addChapterController.subjectList
                                        .map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: e == ""
                                              ? const Text(
                                                  "Select Subject",
                                                  style: TextStyle(
                                                      fontFamily: "calibri",
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                )
                                              : Text(e));
                                    }).toList(),
                                    onChanged: (val) {
                                      addChapterController.subjectValue.value =
                                          val.toString();
                                      paperGenerateController
                                          .subjectName.value = val.toString();
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : addChapterController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => !addChapterController.isChapterName.value
                      ? Container()
                      : Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Time allowed",
                              style: TextStyle(
                                fontFamily: "calibri",
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                  onChanged: (value) {
                                    paperGenerateController.time.value =
                                        value.toString();
                                  },
                                  maxLines: 1,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: "Add test time limit",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => !addChapterController.isChapterName.value
                    ? Container()
                    : Column(
                        children: [
                          Row(
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Instructions",
                                  style: TextStyle(
                                    fontFamily: "calibri",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromRGBO(51, 51, 51, 1),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                    onChanged: (value) {
                                      paperGenerateController
                                          .instruction.value = value.toString();
                                    },
                                    maxLines: 6,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    decoration: InputDecoration(
                                      hintText: "Instruction here",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      paperGenerateController.getBlueprint();
                      tabController.animateTo(1);
                    },
                    child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      color: Colors.blue,
                      child: const Text('Next',
                          style: TextStyle(
                              fontFamily: "calibri",
                              fontSize: 25,
                              color: Colors.white)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
