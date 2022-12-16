// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewQuestionBankController extends GetxController {
  final isLoading = false.obs;
  final buttonPressed = false.obs;
  final loadedData = false.obs;
  final classValue = "".obs;
  final subjectValue = "".obs;
  final chapterValue = "".obs;
  final questionTypeValue = "".obs;
  final classSelectedIndex = 0.obs;
  List<dynamic> subjectList = [""].obs;
  List<dynamic> chaptersList = [""].obs;
  List<dynamic> chaptersIdList = [""].obs;
  final questionSelectedIndex = 0.obs;
  final dataLoading = false.obs;
  final questions = [];
  final mcqList = [].obs;
  final desList = [].obs;
  final caseBaseMcqList = [].obs;
  final caseBaseDesList = [].obs;
  final pictorgraphQueList = [].obs;
  final graphList = [].obs;
  final mapList = [].obs;
  final matchFollowingList = [].obs;
  final matchObjWithTextList = [].obs;

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

  // List<String> questionTypeList = [
  //   "",
  //   "Choose Correct Answer",
  //   "Fill in the blanks",
  //   "True & False",
  //   "Match the following",
  //   "Subjective/One word QA/Very Short Answer",
  //   "Subjective/Short Answer(2 marks)",
  //   "Subjective Question(3 marks)",
  //   "Subjective Question(4 marks)",
  //   "Subjective Question(5 marks)",
  //   "Case Base Question (MCQ Type)",
  //   "Case Base Question (Short Answer)",
  //   "Graph Question",
  //   "Map Question",
  // ];

  final firestore = FirebaseFirestore.instance;

  getSubject(String className) async {
    isLoading.toggle();
    subjectList = [];
    subjectValue.value = "";
    await firestore
        .collection("question_bank")
        .doc(className)
        .get()
        .then((value) {
      subjectList = value.data()!['subject'];
      subjectList.insert(0, "");
    });
    isLoading.toggle();
  }

  getChapters(String className, String subjectName) async {
    isLoading.toggle();
    chaptersList = [];
    chaptersIdList = [];
    chapterValue.value = "";
    await firestore
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

        chaptersList = tmp;
        chaptersIdList = tmpId;
        chaptersIdList.insert(0, "");
        chaptersList.insert(0, "");
      }
    });
    isLoading.toggle();
  }

  fetchData(String chapterId) async {
    dataLoading.value = true;
    buttonPressed.value = true;
    desList.value = [];
    mcqList.value = [];
    caseBaseMcqList.value = [];
    caseBaseDesList.value = [];
    graphList.value = [];
    mapList.value = [];
    matchFollowingList.value = [];
    matchObjWithTextList.value = [];
    pictorgraphQueList.value = [];
    try {
      await firestore
          .collection("question_bank")
          .doc(classValue.value)
          .collection(subjectValue.value)
          .doc(chapterId)
          .collection("questions")
          .doc("type $questionSelectedIndex")
          .get()
          .then((value) {
        if (questionSelectedIndex.value == 29) {
          if (value.data()!.containsKey("questionList")) {
            mcqList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 32 ||
            questionSelectedIndex.value == 74) {
          if (value.data()!.containsKey("questionList")) {
            matchFollowingList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 38) {
          if (value.data()!.containsKey("questionList")) {
            pictorgraphQueList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 22) {
          if (value.data()!.containsKey("questionList")) {
            matchObjWithTextList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 81 ||
            questionSelectedIndex.value == 89 ||
            questionSelectedIndex.value == 90) {
          if (value.data()!.containsKey("questionList")) {
            caseBaseMcqList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 47 ||
            questionSelectedIndex.value == 48 ||
            questionSelectedIndex.value == 49 ||
            questionSelectedIndex.value == 56 ||
            questionSelectedIndex.value == 57) {
          if (value.data()!.containsKey("questionList")) {
            caseBaseDesList.value = value.data()!['questionList'];
          }
        } else if ((questionSelectedIndex.value >= 1 &&
                questionSelectedIndex.value <= 28) ||
            (questionSelectedIndex.value >= 33 &&
                questionSelectedIndex.value <= 60) ||
            (questionSelectedIndex.value >= 62 &&
                questionSelectedIndex.value <= 71) ||
            (questionSelectedIndex.value >= 73 &&
                questionSelectedIndex.value <= 94)) {
          if (value.data()!.containsKey("questionList")) {
            desList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 61) {
          if (value.data()!.containsKey("questionList")) {
            graphList.value = value.data()!['questionList'];
          }
        } else if (questionSelectedIndex.value == 72) {
          if (value.data()!.containsKey("questionList")) {
            mapList.value = value.data()!['questionList'];
          }
        }
      });
      dataLoading.value = false;
    } catch (e) {
      dataLoading.value = false;
    }
  }
}
