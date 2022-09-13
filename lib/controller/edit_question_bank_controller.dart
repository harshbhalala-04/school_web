import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditQuestionBankController extends GetxController {
  final isLoading = false.obs;
  final classValue = "".obs;
  final subjectValue = "".obs;
  final chapterValue = "".obs;
  final questionTypeValue = "".obs;
  final classSelectedIndex = 0.obs;
  List<dynamic> subjectList = [""].obs;
  List<dynamic> chaptersList = [""].obs;
  List<dynamic> chaptersIdList = [""].obs;
  final questionSelectedIndex = 0.obs;

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
        print(chaptersIdList);
      }
    });
    isLoading.toggle();
  }
}
