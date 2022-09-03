import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:school_web/controller/add_blueprint_controller.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/desktop_appbar.dart';
import 'package:school_web/widgets/footer.dart';
import 'package:school_web/widgets/side_layout.dart';
import 'package:school_web/widgets/theme_button.dart';

class AddBlueprintScreen extends StatefulWidget {
  const AddBlueprintScreen({Key? key}) : super(key: key);

  @override
  State<AddBlueprintScreen> createState() => _AddBlueprintScreenState();
}

class _AddBlueprintScreenState extends State<AddBlueprintScreen> {
  final AddBlueprintController addBlueprintController =
      Get.put(AddBlueprintController());
  List<Widget> _cardList = [];
  void _addCardWidget() {
    print('5454554');
    setState(() {
      // _cardList.add(_card());
    });
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
              colors: themeColor)),
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
            children: [
              Card(
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
                        children: [
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
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
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
                                        addBlueprintController.classValue.value,
                                    items: addBlueprintController.classList
                                        .map((e) {
                                      return DropdownMenuItem(
                                          value: e,
                                          child: e == ""
                                              ? const Text(
                                                  "Select Class",
                                                  style: TextStyle(
                                                      fontFamily: "calibri",
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                )
                                              : Text(e));
                                    }).toList(),
                                    onChanged: (val) {
                                      addBlueprintController.getSubjectList(
                                          val.toString(), false);
                                      addBlueprintController.classValue.value =
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
                        () => addBlueprintController.isSubjectVisible.value
                            ? Row(
                                children: [
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
                                      height: 40,
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
                                          hint: const Text(
                                            "Select Subject",
                                            style: TextStyle(
                                                fontFamily: "calibri",
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                          value: addBlueprintController
                                              .subjectValue.value,
                                          items: addBlueprintController
                                              .subjectList
                                              .map((e) {
                                            return DropdownMenuItem(
                                                value: e,
                                                child: e == ""
                                                    ? const Text(
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
                                            addBlueprintController.subjectValue
                                                .value = val.toString();

                                            addBlueprintController.getChapters(
                                                addBlueprintController
                                                    .classValue.value,
                                                val.toString());
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : addBlueprintController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => addBlueprintController.isChapterName.value
                            ? Container(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: addBlueprintController
                                        .chaptersList.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        child: Text(addBlueprintController
                                            .chaptersList[index]),
                                      );
                                    })),
                              )
                            : addBlueprintController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                     
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                        itemCount: _cardList.length,
                        itemBuilder: (context, index) {
                          return _cardList[index];
                        }
                        ),
                      GestureDetector(
                        onTap: () {
                          _addCardWidget();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.white,
                          child: const Text('Add Question Set'),
                        ),
                      ),
                      ThemeButton(text: "Add BluePrint"),
                    ],
                  ),
                ),
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _card(addBlueprintController) {
  final AddBlueprintController addBlueprintController =
      Get.put(AddBlueprintController());
      print(addBlueprintController.questionTypeList.toString());
  // List<String> questionType = addBlueprintController.questionTypeList;
  // String selectedQuestionType = questionType.first;
  // print(questionType);
    return Card(
      child: Column(
        children: [
          const Text('Question Set A'),
          Row(
            children: const [
              Text('Question set Statement'),
              Flexible(
                child: TextField(),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Question Type'),
              Container(
                height: 40,
                //  width: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
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
                      hint: const Text(
                        "Select Question Type",
                        style: TextStyle(
                            fontFamily: "calibri",
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                      value: addBlueprintController.questionTypeValue.value,
                      items: addBlueprintController.questionTypeList
                          .map((e) {
                        return DropdownMenuItem(
                            value: e,
                            child: e == ""
                                ? const Text(
                                    "Select Question Type",
                                    style: TextStyle(
                                        fontFamily: "calibri",
                                        fontSize: 18,
                                        color: Colors.grey),
                                  )
                                : Text(e));
                      }).toList(),
                      onChanged: (val) {
                      // addBlueprintController.questionSet[index] = val.toString();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }





//  Container(
//                                   height: 40,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     borderRadius: const BorderRadius.all(
//                                       Radius.circular(10),
//                                     ),
//                                     border: Border.all(
//                                         color: Colors.black38, width: 0.8),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: DropdownButton(
//                                       underline: Container(),
//                                       hint: const Text(
//                                         "Select Chapter",
//                                         style: TextStyle(
//                                             fontFamily: "calibri",
//                                             fontSize: 18,
//                                             color: Colors.grey),
//                                       ),
//                                       value:
//                                           addBlueprintController.chapterValue.value,
//                                       items: addBlueprintController.chaptersList
//                                           .map((e) {
//                                         return DropdownMenuItem(
//                                             value: e,
//                                             child: e == ""
//                                                 ? const Text(
//                                                     "Select Chapter",
//                                                     style: TextStyle(
//                                                         fontFamily: "calibri",
//                                                         fontSize: 18,
//                                                         color: Colors.grey),
//                                                   )
//                                                 : Text(e));
//                                       }).toList(),
//                                       onChanged: (val) {
//                                         addBlueprintController.chapterValue.value =
//                                             val.toString();
//                                       },
//                                     ),
//                                   ),
//                                 ),