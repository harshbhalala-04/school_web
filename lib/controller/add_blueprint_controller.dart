import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_web/model/Question_model.dart';

class AddBlueprintController extends GetxController {
  final classValue = "".obs;
  final subjectValue = "".obs;
  final chapterValue = "".obs;
  final bluePrintName = "".obs;
  
  final isLoading = false.obs;
  final isSubjectVisible = false.obs;
  final isChapterName = false.obs;
  final isChapterNumber = false.obs;
  final List<bool> isAddQuestionSet = [false].obs;
  List<dynamic> subjectList = [""].obs;
  List<dynamic> chaptersList = [""].obs;
  List<dynamic> chaptersIdList = [""].obs;
  List<Chapter> chapters = <Chapter>[].obs;

  final viewChapterClassValue = "".obs;
  final viewChapterSubjectValue = "".obs;
  List<dynamic> viewChapterSubjectList = [""].obs;
  final questionTypeValue = "".obs;

  final viewChapterSubjectVisible = false.obs;

  List<QuestionSetModel> questionSetList = <QuestionSetModel>[].obs;

  List<String> classList = [
    "",
    "Nursery",
    "LKG",
    "UKG",
    "Class 1",
    "Class 2",
    "Class 3",
    "Class 4",
    "Class 5",
    "Class 6",
    "Class 7",
    "Class 8",
    "Class 9",
    "Class 10"
  ];

  

  getSubjectList(String className, bool fromViewChapter) async {
    isSubjectVisible.value = false;
    isChapterName.value = false;
    isChapterNumber.value = false;
    if (fromViewChapter) {
      viewChapterSubjectVisible.value = false;
    }

    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .get()
        .then((value) {
      subjectList = value.data()!['subject'];
      subjectList.insert(0, "");
      if (fromViewChapter) {
        viewChapterSubjectList = value.data()!['subject'];
        viewChapterSubjectList.insert(0, "");
      }
    });

    isLoading.toggle();
    isSubjectVisible.value = true;
    isChapterName.value = true;
    isChapterNumber.value = true;
    if (fromViewChapter) {
      viewChapterSubjectVisible.value = true;
    }
  }

  getChapters(String className, String subjectName) async {
    isChapterName.value = false;
    isChapterNumber.value = false;
    isLoading.toggle();

    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .get()
        .then((value) {
      if (value.data()![subjectName] != null) {
        final chapterMap = value.data()![subjectName];

        List<dynamic> tmp = [];
        List<dynamic> tmpId = [];
        chapterMap.forEach((key, value) {
          tmp.add("$key. ${value['chapterName']}");
        });
        chapterMap.forEach((key, value) {
          tmpId.add("${value['chapterId']}");
        });
        chapterMap.forEach((key, value) {
          chapters.add(Chapter(value['chapterId'], value['chapterName']));
        });

        chaptersList = tmp;
        chaptersIdList = tmpId;
        chaptersIdList.insert(0, "");
        chaptersList.insert(0, "");
      }
    });
    isLoading.toggle();
    isChapterName.value = true;
    isChapterNumber.value = true;
  }

  Future<int> getQestionTypeMax(String className, String subjectName,
      String subjectId, String type) async {
    int maxNum = 0;
    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(subjectId)
        .collection('questions')
        .doc(type)
        .get()
        .then((value) {
      if (value.exists) {
        maxNum = value.data()!['questionList'].length;
      }
    });
    return maxNum;
  }

  addBluprintToFirestore(
      {blueprintName,
      className,
      subjectName,
      required List<QuestionSetModel> questionSet}) async {
    makeList() {
      List tempQuestionSetList = [];
      for (var element in questionSet) {
        tempQuestionSetList.add(element.createMap());
      }
      return tempQuestionSetList;
    }

    await FirebaseFirestore.instance.collection('Blueprint').add({
      'BluePrintName': blueprintName,
      'Class': className,
      'SubjectName': subjectName,
      'QuestionSet': makeList(),
    });
  }
}

class Chapter {
  String id;
  String name;
  Chapter(this.id, this.name);
}
