import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final firestore = FirebaseFirestore.instance;

  addChapterToSubject(String className, String subjectName,
      String chapterNumber, String chapterName) async {
    // "maths": ["1": "Trigonometry", "2": "qwuqw", "3": "ssassa"]
    String chapterId = chapterName + DateTime.now().toString();
    await firestore
        .collection("question_bank")
        .doc(className)
        .get()
        .then((val) async {
      Map<String, dynamic> mp = val.data()!;
      Map<String, dynamic> myMap = {};
      if (mp.containsKey(subjectName)) {
        myMap = mp[subjectName];
      }

      myMap[chapterNumber] = {
        "chapterName": chapterName,
        "chapterId": chapterId
      };

      mp[subjectName] = myMap;
      await firestore
          .collection("question_bank")
          .doc(className)
          .update({subjectName: mp[subjectName]});
    });

    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterId)
        .set({});

    for (int i = 0; i <= 94; i++) {
      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterId)
          .collection("questions")
          .doc("type $i")
          .set({});
    }
  }

  setMcqQuestion(
      String className,
      String subjectName,
      String chapterName,
      String chapterID,
      String question,
      String optionA,
      String optionB,
      String optionC,
      String optionD,
      String questionImg,
      String optionAImg,
      String optionBImg,
      String optionCImg,
      String optionDImg) async {
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .collection("questions")
        .doc("type 29")
        .update({
      "questionList": FieldValue.arrayUnion([
        {
          "questionText": question,
          "questionImg": questionImg,
          "optionA": optionA,
          "optionAImg": optionAImg,
          "optionB": optionB,
          "optionBImg": optionBImg,
          "optionC": optionC,
          "optionCImg": optionCImg,
          "optionD": optionD,
          "optionDImg": optionDImg,
        }
      ])
    });
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;

      if (val.data()!.isNotEmpty) {
        if (val.data()!["type 29"] != null) {
          newValue = val.data()!["type 29"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type 29": newValue});
    });
  }

  setMatchFollowingQue(String className, String subjectName, String chapterName,
      String chapterID, String partA, String partB, int typeNumber) async {
    if (typeNumber == 22) {
      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .collection("questions")
          .doc("type $typeNumber")
          .update({
        "questionList": FieldValue.arrayUnion([
          {"imgUrl": partA, "partB": partB}
        ])
      });
    } else {
      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .collection("questions")
          .doc("type $typeNumber")
          .update({
        "questionList": FieldValue.arrayUnion([
          {"partA": partA, "partB": partB}
        ])
      });
    }

    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;
      if (val.data()!.isNotEmpty) {
        if (val.data()!["type $typeNumber"] != null) {
          newValue = val.data()!["type $typeNumber"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type $typeNumber": newValue});
    });
  }

  setFillBlankOrTrueFalseQue(
      String className,
      String subjectName,
      String chapterName,
      String chapterID,
      String question,
      int typeNumber,
      String imgUrl) async {
    print("here set fill blank");
    print("type $typeNumber");
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .collection("questions")
        .doc("type $typeNumber")
        .update({
      "questionList": FieldValue.arrayUnion([
        {"questionText": question, "imgUrl": imgUrl}
      ])
    });
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;
      if (val.data()!.isNotEmpty) {
        if (val.data()!["type $typeNumber"] != null) {
          newValue = val.data()!["type $typeNumber"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type $typeNumber": newValue});
    });
  }

  setCaseBaseMcq(
      List<Map<String, dynamic>> questionMap,
      String paragraph,
      String className,
      String subjectName,
      String chapterName,
      String chapterID,
      String paraImg,
      int typeNumber) async {
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .collection("questions")
        .doc("type $typeNumber")
        .update({
      "questionList": FieldValue.arrayUnion([
        {"questions": questionMap, "paragraph": paragraph, "paraImg": paraImg}
      ])
    });
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;
      if (val.data()!.isNotEmpty) {
        if (val.data()!["type $typeNumber"] != null) {
          newValue = val.data()!["type 10"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type $typeNumber": newValue});
    });
  }

  setCaseBaseDes(
      String para,
      String que1,
      String que2,
      String que3,
      String que4,
      String que5,
      String className,
      String subjectName,
      String chapterName,
      String chapterID,
      String paraImg,
      String que1Img,
      String que2Img,
      String que3Img,
      String que4Img,
      String que5Img,
      int typeNumber) async {
    // 47, 48, 49, 56,57
    Map<String, dynamic> queMap = {
      "question1": que1,
      "question2": que2,
      "question3": que3,
      "question4": que4,
      "question5": que5,
      "question1Img": que1Img,
      "question2Img": que2Img,
      "question3Img": que3Img,
      "question4Img": que4Img,
      "question5Img": que5Img
    };
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .collection("questions")
        .doc("type $typeNumber")
        .update({
      "questionList": FieldValue.arrayUnion([
        {"questions": queMap, "paragraph": para, "paraImg": paraImg}
      ])
    });
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;
      if (val.data()!.isNotEmpty) {
        if (val.data()!["type $typeNumber"] != null) {
          newValue = val.data()!["type $typeNumber"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type $typeNumber": newValue});
    });
  }

  setPictographQue(
      String que1,
      String que2,
      String que3,
      String que4,
      String className,
      String subjectName,
      String chapterName,
      String chapterID,
      String paraImg,
      String que1Img,
      String que2Img,
      String que3Img,
      String que4Img,
      int typeNumber) async {
   
    Map<String, dynamic> queMap = {
      "question1": que1,
      "question2": que2,
      "question3": que3,
      "question4": que4,
      "question1Img": que1Img,
      "question2Img": que2Img,
      "question3Img": que3Img,
      "question4Img": que4Img,
    };
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .collection("questions")
        .doc("type $typeNumber")
        .update({
      "questionList": FieldValue.arrayUnion([
        {"questions": queMap, "paraImg": paraImg}
      ])
    });
    await firestore
        .collection("question_bank")
        .doc(className)
        .collection(subjectName)
        .doc(chapterID)
        .get()
        .then((val) async {
      int newValue = 1;
      if (val.data()!.isNotEmpty) {
        if (val.data()!["type $typeNumber"] != null) {
          newValue = val.data()!["type $typeNumber"] + 1;
        }
      }

      await firestore
          .collection("question_bank")
          .doc(className)
          .collection(subjectName)
          .doc(chapterID)
          .update({"type $typeNumber": newValue});
    });
  }
}
