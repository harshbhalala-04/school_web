class BluePrint {
  String className;
  String subjectName;
  List<QuestionSet> questionSet;
  BluePrint({
    required this.className,
    required this.subjectName,
    required this.questionSet,
  });

}

class QuestionSet {
  String qestionSetStatement;
  String qestionSet;
  String qestionType;
  QuestionSet({
    required this.qestionSetStatement,
    required this.qestionSet,
    required this.qestionType,
  });

}
