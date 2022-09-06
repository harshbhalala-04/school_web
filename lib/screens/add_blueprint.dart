import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/add_blueprint_controller.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/desktop_appbar.dart';
import 'package:school_web/widgets/footer.dart';
import 'package:school_web/widgets/side_layout.dart';
import 'package:school_web/widgets/theme_button.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../model/Question_model.dart';
import '../widgets/QuestionSet_Container.dart';

class AddBlueprintScreen extends StatefulWidget {
  const AddBlueprintScreen({Key? key}) : super(key: key);

  @override
  State<AddBlueprintScreen> createState() => _AddBlueprintScreenState();
}

class _AddBlueprintScreenState extends State<AddBlueprintScreen> {
  final AddBlueprintController addBlueprintController =
      Get.put(AddBlueprintController());
  List<Questions> questionSet = [];
  List _selectedChapter = [];
  List chapterList = [];
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
                                           addBlueprintController.chaptersIdList.clear();
                                           addBlueprintController.chaptersIdList.clear();
                                           addBlueprintController.chapters.clear();
                                           addBlueprintController.questionSetList.clear();
                                           _selectedChapter.clear();
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
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => addBlueprintController.chaptersList.isNotEmpty && addBlueprintController.subjectValue.value != ''
                            ? Container(
                                decoration: BoxDecoration(
                                  
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    MultiSelectBottomSheetField(
                                      initialChildSize: 0.4,
                                      listType: MultiSelectListType.CHIP,
                                      searchable: true,
                                      buttonText: Text("Select Chapters"),
                                      title: Text("Chapters"),
                                      items: addBlueprintController.chapters
                                          .map(
                                            (e) => MultiSelectItem(
                                              e.id,
                                              e.name.toString(),
                                            ),
                                          )
                                          .toList(),
                                      onConfirm: (values) {
                                        _selectedChapter = values;
                                      },
                                      chipDisplay: MultiSelectChipDisplay(
                                        onTap: (value) {
                                          setState(() {
                                            _selectedChapter.remove(value);
                                          });
                                        },
                                      ),
                                    ),
                                    _selectedChapter == null ||
                                            _selectedChapter.isEmpty
                                        ? Container(
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "None selected",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ))
                                        : Container(),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addBlueprintController.questionSetList.length,
                          itemBuilder: (context, index) {
                            return QuestionSetWidget(
                              callback: refresh,
                              index: index,
                              questions: addBlueprintController.questionSetList,
                              chaptersList: _selectedChapter.toList(),
                            );
                          }),
                      Obx(() => addBlueprintController.subjectValue.value != ''
                          ? GestureDetector(
                              onTap: () {
                                addBlueprintController.questionSetList.add(Questions(
                                  itemName: "",
                                ));
                                questionSet.add(Questions(
                                  itemName: "",
                                ));
                              
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                color: Colors.white,
                                child: const Text('Add Question Set'),
                              ),
                            )
                          : const SizedBox.shrink()),
                      questionSet.length > 0
                          ? GestureDetector(
                            onTap: () {
                              
                              addBlueprintController.printSelectedList(addBlueprintController.questionSetList);
                            },
                            child: Container(child: Text('Add BluePrint'),))
                          : const SizedBox.shrink()
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
