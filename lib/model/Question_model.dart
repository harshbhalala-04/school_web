import 'package:school_web/controller/add_blueprint_controller.dart';

class QuestionSetModel {
  String questionType;
  String questionStatement;
  List<Map<String,String>>? chapterWithRequiredQues;
  QuestionSetModel({
    required this.questionType,
    required this.questionStatement,
    this.chapterWithRequiredQues,
  });

  Map<String, dynamic> createMap() {
    return {
      'questionType' : questionType,
      'questionStatement' : questionStatement,
      'chapterRequird' :  getList()
    };
  } 
  getList() {
    Map temp = {};
    chapterWithRequiredQues?.forEach((element) {
      temp.addAll({
        element.keys.first : element.values.first.toString()
      });
    });
    return temp;
  }
}
