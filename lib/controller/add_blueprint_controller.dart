import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:school_web/model/Question_model.dart';

class AddBlueprintController extends GetxController {
  final classValue = "".obs;
  final subjectValue = "".obs;
  final chapterValue = "".obs;

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

  List<String> questionTypeList = [
    "",
    "Choose Correct Answer",
    "Fill in the blanks",
    "True & False",
    "Match the following",
    "Subjective/One word QA/Very Short Answer",
    "Subjective/Short Answer(2 marks)",
    "Subjective Question(3 marks)",
    "Subjective Question(4 marks)",
    "Subjective Question(5 marks)",
    "Case Base Question (MCQ Type)",
    "Case Base Question (Short Answer)",
    "Graph Question",
    "Map Question",
  ];

  getSubjectList(String className, bool fromViewChapter) async {
    isSubjectVisible.value = false;
    isChapterName.value = false;
    isChapterNumber.value = false;
    if (fromViewChapter) {
      viewChapterSubjectVisible.value = false;
    }

    isLoading.toggle();
    for (int i = 1; i < classList.length; i++) {
      await FirebaseFirestore.instance
          .collection("question_bank")
          .doc(className)
          .get()
          .then((val) {
        subjectList = val.data()!['subject'];
        if (fromViewChapter) {
          viewChapterSubjectList = val.data()!['subject'];
          viewChapterSubjectList.insert(0, "");
        }

        subjectList.insert(0, "");
      });
    }

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
        chapterMap.forEach((key,value) {
          chapters.add(
            Chapter(value['chapterId'], value['chapterName'])
          );
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


 Future<int> getQestionTypeMax(String className, String subjectName,String subjectId,String type) async {

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
          if(value.exists) {
              maxNum = value.data()!['questionList'].length;
          }
        });
         return maxNum;
  }

  addBluprintToFirestore({className,subjectName,chapterIdList,chapterNameList}) async {
    await FirebaseFirestore.instance.collection('Blueprint').add({
      'class' : className,
      'subjectName' : subjectName,
      'chapterIdList' : chapterIdList,
      'chapterNameList' : chapterNameList,
    });
  }

}

class Chapter {
   String id;
   String name;
  Chapter(this.id, this.name);
}
