import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/blueprint_model.dart';

class ViewBlueprintController extends GetxController {
  final classValue = "".obs;
  final subjectValue = "".obs;
  final isSingleBlueprintLoad = false.obs;
  final isLoading = false.obs;
  final isBlueprintLoading = false.obs;
  final isSubjectVisible = false.obs;

  List<dynamic> subjectList = [""].obs;

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
  final RxList<BluePrint> blueprints = <BluePrint>[].obs;

  getSubjectList(String className, bool fromViewChapter) async {
    isSubjectVisible.value = false;

    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("question_bank")
        .doc(className)
        .get()
        .then((value) {
      subjectList = value.data()!['subject'];
      subjectList.insert(0, "");
      
    });

    isLoading.toggle();
    isSubjectVisible.value = true;
   
  }

   getBlueprint() async {
    blueprints.value = [];
    isBlueprintLoading.toggle();
    await FirebaseFirestore.instance
        .collection('Blueprint')
        .where('Class', isEqualTo: classValue.value)
        .where('SubjectName', isEqualTo: subjectValue.value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        blueprints.add(
          BluePrint(
              className: element['Class'],
              blueprindId: element['BluePrintId'],
              blueprintName: element['BluePrintName'],
              subjectName: element['SubjectName'],
              questionSet: element['QuestionSet'],
              totalMarks: element['totalMarks'] ?? 0,
              totalQuestions: element['totalQuestions'] ?? 0,
              selectedChaptersName: element['selectedChaptersName']),
        );
      });
    });
    isBlueprintLoading.toggle();
  }
}
