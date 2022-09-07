import 'package:school_web/controller/add_blueprint_controller.dart';

class QuestionSetModel {
  String questionType;
  String questionStatement;
  // List<ChapterWithMax> chapterList;
  Map<String,int>? chapterWithRequiredQues;
  QuestionSetModel({
    required this.questionType,
    required this.questionStatement,
    this.chapterWithRequiredQues,
    // required this.chapterList,
  });
}

class ChapterWithMax extends Chapter {
  ChapterWithMax(super.id, super.name,this.max);
  String max;
}