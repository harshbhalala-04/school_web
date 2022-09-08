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
 
}

  Map asMap(questionSetModel) => {
   'questionType' :questionSetModel.questionType,
   'questionStatement' : questionSetModel.questionStatement,
   'ChapterWithRequiredQues' : questionSetModel.chapterWithRequiredQues,
  };


