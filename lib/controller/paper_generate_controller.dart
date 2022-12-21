// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../model/blueprint_model.dart';
import '../widgets/paper.dart';

class PaperGenerateController extends GetxController {
  final testPaperName = ''.obs;
  final className = ''.obs;
  final subjectName = ''.obs;
  final time = ''.obs;
  final instruction = ''.obs;
  final RxList<BluePrint> blueprints = <BluePrint>[].obs;
  final isLoading = false.obs;
  var selectedBlueprintIndex = -1.obs;
  List<Map<String, dynamic>> paper = [];
  final isPaperGenerating = false.obs;

  getBlueprint() async {
    print(className);
    print(subjectName);
    blueprints.value = [];
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection('Blueprint')
        .where('Class', isEqualTo: className.value)
        .where('SubjectName', isEqualTo: subjectName.value)
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
    isLoading.toggle();
  }

  List<String> partAList = [];
  List<String> partBList = [];
  List<String> partA74List = [];
  List<String> partB74List = [];
  List<List<String>> overAll74List = [];
  List<List<String>> overAllList = [];
  List<dynamic> images = [];
  List<dynamic> partAImagesList = [];
  List<String> partBImageNameList = [];

  generatePaper(String blueprintId) async {
    isPaperGenerating.toggle();
    paper = [];
    int idx =
        blueprints.indexWhere((element) => element.blueprindId == blueprintId);

    for (int i = 0; i < blueprints[idx].questionSet.length; i++) {
      Map<dynamic, dynamic> requiredQuestionsMap =
          blueprints[idx].questionSet[i]['RequiredQuestion'];
      List<dynamic> singleQuestionSetQuestionsList = [];
      for (var chapterId in requiredQuestionsMap.keys) {
        print(chapterId);
        var questions = requiredQuestionsMap[chapterId];
        if (int.tryParse(questions)! == 0) {
          continue;
        }
        List<dynamic> finalQuestionsList = [];
        List<dynamic> questionsList = [];
        List<dynamic> shuffleQuestionsList = [];
        await FirebaseFirestore.instance
            .collection("question_bank")
            .doc(blueprints[idx].className)
            .collection(blueprints[idx].subjectName)
            .doc(chapterId)
            .collection("questions")
            .doc(blueprints[idx].questionSet[i]['QuestionType'])
            .get()
            .then((val) async {
          questionsList = val.data()?['questionList'];
          shuffleQuestionsList = questionsList..shuffle();
          finalQuestionsList = shuffleQuestionsList;
          if (int.tryParse(questions)! + 1 <= shuffleQuestionsList.length) {
            finalQuestionsList = shuffleQuestionsList
              ..removeRange(
                  int.tryParse(questions)!, shuffleQuestionsList.length);
          }
          singleQuestionSetQuestionsList.addAll(finalQuestionsList);
        });
      }
      if (blueprints[idx].questionSet[i]['QuestionType'] == "type 22") {
        for (int i = 0; i < singleQuestionSetQuestionsList.length; i++) {
          final image =
              await networkImage(singleQuestionSetQuestionsList[i]['imgUrl']);
          partAImagesList.add(image);
          partBImageNameList.add(singleQuestionSetQuestionsList[i]['partB']);
        }
        partAImagesList.shuffle();
        partBImageNameList.shuffle();
      } else if (blueprints[idx].questionSet[i]['QuestionType'] == "type 32") {
        for (int i = 0; i < singleQuestionSetQuestionsList.length; i++) {
          partAList.add(singleQuestionSetQuestionsList[i]['partA']);
          partBList.add(singleQuestionSetQuestionsList[i]['partB']);
        }
        partAList.shuffle();
        partBList.shuffle();
        print("this is part a list");
        print(partAList);
        print("this is part b list");
        print(partBList);
        overAllList.add(["A", "B"]);
        for (int i = 0; i < partAList.length; i++) {
          int number = i + 65;
          String op = String.fromCharCode(number);
          overAllList
              .add(["${i + 1}.  ${partAList[i]}", "$op.  ${partBList[i]}"]);
        }
        print("this is over all list");
        print(overAllList);
        // print(singleQuestionSetQuestionsList);
      } else if (blueprints[idx].questionSet[i]['QuestionType'] == "type 74") {
        for (int i = 0; i < singleQuestionSetQuestionsList.length; i++) {
          partA74List.add(singleQuestionSetQuestionsList[i]['partA']);
          partB74List.add(singleQuestionSetQuestionsList[i]['partB']);
        }
        partA74List.shuffle();
        partB74List.shuffle();
        print("this is part a list");
        print(partA74List);
        print("this is part b list");
        print(partB74List);
        overAll74List.add(["A", "B"]);
        for (int i = 0; i < partA74List.length; i++) {
          int number = i + 65;
          String op = String.fromCharCode(number);
          overAll74List
              .add(["${i + 1}.  ${partA74List[i]}", "$op.  ${partB74List[i]}"]);
        }
        print("this is over all list");
        print(overAll74List);
      }

      for (int questionSetIndex = 0;
          questionSetIndex < singleQuestionSetQuestionsList.length;
          questionSetIndex++) {
        if (blueprints[idx].questionSet[i]['QuestionType'] == "type 38") {
          //Pictograph
          final netImage = await networkImage(
              singleQuestionSetQuestionsList[questionSetIndex]['paraImg']);
          images.add(netImage);
          int idx = images.indexWhere((element) => element == netImage);
          singleQuestionSetQuestionsList[questionSetIndex]['paraImgIndex'] =
              idx;
        } else if (blueprints[idx].questionSet[i]['QuestionType'] ==
            "type 29") {
          //Mcq question
          if (singleQuestionSetQuestionsList[questionSetIndex]['questionImg'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]
                    ['questionImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['questionImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['questionImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[questionSetIndex]['optionAImg'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]['optionAImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionAImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionAImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[questionSetIndex]['optionBImg'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]['optionBImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionBImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionBImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[questionSetIndex]['optionCImg'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]['optionCImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionCImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionCImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[questionSetIndex]['optionDImg'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]['optionDImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionDImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['optionDImgIndex'] = -1;
          }
        } else if (blueprints[idx].questionSet[i]['QuestionType'] ==
                "type 22" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 32" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 74" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 47" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 48" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 49" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 56" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 57" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 81" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 89" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 90") {
          //match the picture of obj with name question
          continue;
        } else {
          //Description of img, Graph, map, maths, image only question & all other questions
          if (singleQuestionSetQuestionsList[questionSetIndex]['imgUrl'] !=
              "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[questionSetIndex]['imgUrl']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[questionSetIndex]
                ['questionImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[questionSetIndex]
                ['questionImgIndex'] = -1;
          }
        }
      }
      paper.add({
        "questionStatement": blueprints[idx].questionSet[i]
            ['QuestionStatement'],
        "QuestionType": blueprints[idx].questionSet[i]['QuestionType'],
        "questions": singleQuestionSetQuestionsList
      });
    }
    print(paper.length);
    for (int i = 0; i < paper.length; i++) {
      print(paper[i]['questionStatement']);
      print(paper[i]['questions']);
      print(paper[i]['QuestionType']);
    }
    isPaperGenerating.toggle();
    Get.toNamed('/paper_pdf_view');
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final font3 = await PdfGoogleFonts.tinosRegular();
    final font4 = await PdfGoogleFonts.tinosBold();

    var assetImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );
    final hindiFont = await rootBundle.load("assets/fonts/Hind.ttf");
    final hindiFontTTF = pw.Font.ttf(hindiFont);

    doc.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: font1,
          bold: font2,
        ),
        mainAxisAlignment: pw.MainAxisAlignment.start,
        pageFormat: format.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return pw.Header(
              level: 1,
              title: 'Question Paper',
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Image(assetImage, height: 60, width: 60),
                      pw.SizedBox(width: 30),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text(
                            "St.Xaviers CMI Public School",
                            style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize: 24,
                              fontFallback: [hindiFontTTF],
                              font: font4,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                          pw.Text(
                            "Half Yearly Exam(september-2022)",
                            style: pw.TextStyle(
                              fontFallback: [hindiFontTTF],
                              color: PdfColors.black,
                              fontSize: 20,
                              font: font4,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "Std:- ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontFallback: [hindiFontTTF],
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "3",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "Marks:- ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontFallback: [hindiFontTTF],
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "50",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "Date:- ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontFallback: [hindiFontTTF],
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "21-09-2022",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(right: 40),
                        child: pw.Text(
                          "Social Science",
                          style: pw.TextStyle(
                            color: PdfColors.black,
                            fontFallback: [hindiFontTTF],
                            fontSize: 16,
                            font: font4,
                            fontWeight: pw.FontWeight.bold,
                            decoration: pw.TextDecoration.underline,
                          ),
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "Time:- ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontFallback: [hindiFontTTF],
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "2 hrs",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.5, color: PdfColors.grey))),
              child: pw.Text('Question Paper',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
          Paper(
            child: pw.ListView.builder(
              itemCount: paper.length,
              itemBuilder: (ctx, index) {
                return pw.Column(children: [
                  pw.SizedBox(height: 10),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "Q.${index + 1}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontFallback: [hindiFontTTF],
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text: "\t${paper[index]['questionStatement']}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font4,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.ListView.builder(
                    itemCount: paper[index]['questions'].length,
                    itemBuilder: (_, idx) {
                      if (paper[index]['QuestionType'] == "type 32") {
                        // Match the following question type 1
                        if (idx == 0) {
                          return pw.Table.fromTextArray(
                              context: _, data: overAllList);
                        }
                        return pw.Container();
                      } else if (paper[index]['QuestionType'] == "type 74") {
                        // Match the followint question type 2
                        if (idx == 0) {
                          return pw.Table.fromTextArray(
                              context: _, data: overAll74List);
                        }
                        return pw.Container();
                      } else if (paper[index]['QuestionType'] == "type 38") {
                        // Pictograph questions
                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "${idx + 1}.",
                                  style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontFallback: [hindiFontTTF],
                                    fontSize: 14,
                                    font: font3,
                                  ),
                                ),
                                pw.Image(
                                    images[paper[index]['questions'][idx]
                                        ['paraImgIndex']],
                                    width: 200,
                                    height: 200),
                              ],
                            ),
                            pw.Text(
                                "\t\t1. ${paper[index]['questions'][idx]['questions']['question1']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t2. ${paper[index]['questions'][idx]['questions']['question2']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t3. ${paper[index]['questions'][idx]['questions']['question3']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t4. ${paper[index]['questions'][idx]['questions']['question4']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                          ],
                        );
                      } else if (paper[index]['QuestionType'] == "type 61" ||
                          paper[index]['QuestionType'] == "type 72" ||
                          paper[index]['QuestionType'] == "type 82") {
                        //Description of img, graph, map question
                        print(
                            paper[index]['questions'][idx]['questionImgIndex']);
                        return paper[index]['questions'][idx]
                                    ['questionImgIndex'] ==
                                -1
                            ? pw.Container()
                            : pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "${idx + 1}.",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontFallback: [hindiFontTTF],
                                          fontSize: 14,
                                          font: font3,
                                        ),
                                      ),
                                      pw.Image(
                                          images[paper[index]['questions'][idx]
                                              ['questionImgIndex']],
                                          width: 300,
                                          height: 300)
                                    ],
                                  ),
                                  pw.Text(paper[index]['questions'][idx]
                                      ['questionText'], style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                                  pw.SizedBox(height: 10),
                                ],
                              );
                      } else if (paper[index]['QuestionType'] == "type 29") {
                        // MCQ questions
                        return pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.RichText(
                                  text: pw.TextSpan(
                                    children: [
                                      pw.TextSpan(
                                        text: "${idx + 1}.",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontFallback: [hindiFontTTF],
                                          fontSize: 14,
                                          font: font3,
                                        ),
                                      ),
                                      pw.TextSpan(
                                        text:
                                            "\t${paper[index]['questions'][idx]['questionText']}",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 14,
                                          font: font3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                paper[index]['questions'][idx]
                                            ['questionImgIndex'] !=
                                        -1
                                    ? pw.Image(
                                        images[paper[index]['questions'][idx]
                                            ['questionImgIndex']],
                                        width: 200,
                                        height: 200,
                                      )
                                    : pw.Container(),
                                pw.SizedBox(height: 2),
                                paper[index]['questions'][idx]
                                                ['optionAImgIndex'] !=
                                            -1 &&
                                        paper[index]['questions'][idx]
                                                ['optionBImgIndex'] !=
                                            -1 &&
                                        paper[index]['questions'][idx]
                                                ['optionCImgIndex'] !=
                                            -1 &&
                                        paper[index]['questions'][idx]
                                                ['optionDImgIndex'] !=
                                            -1
                                    ? pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text("\t\t\ta)\t", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                                          pw.Image(
                                            images[paper[index]['questions']
                                                [idx]['optionAImgIndex']],
                                            width: 100,
                                            height: 100,
                                          ),
                                          pw.Text("\t\t\tb)\t", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                                          pw.Image(
                                            images[paper[index]['questions']
                                                [idx]['optionBImgIndex']],
                                            width: 100,
                                            height: 100,
                                          ),
                                          pw.Text("\t\t\tc)\t", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                                          pw.Image(
                                            images[paper[index]['questions']
                                                [idx]['optionCImgIndex']],
                                            width: 100,
                                            height: 100,
                                          ),
                                          pw.Text("\t\t\td)\t", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                                          pw.Image(
                                            images[paper[index]['questions']
                                                [idx]['optionDImgIndex']],
                                            width: 100,
                                            height: 100,
                                          ),
                                        ],
                                      )
                                    : pw.Text(
                                        "\t\t\ta)\t${paper[index]['questions'][idx]['optionA']}\t\tb)\t${paper[index]['questions'][idx]['optionB']}\t\tc)\t${paper[index]['questions'][idx]['optionC']}\t\td)\t${paper[index]['questions'][idx]['optionD']}",
                                        style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontFallback: [hindiFontTTF],
                                          fontSize: 14,
                                          font: font3,
                                        ),
                                      ),
                              ],
                            ),
                            pw.SizedBox(height: 3),
                          ],
                        );
                      } else if (paper[index]['QuestionType'] == "type 47" ||
                          paper[index]['QuestionType'] == "type 48" ||
                          paper[index]['QuestionType'] == "type 49" ||
                          paper[index]['QuestionType'] == "type 56" ||
                          paper[index]['QuestionType'] == "type 57") {
                        // Passage reading/Case base des questions
                        print(paper[index]['questions'][idx]['paragraph']);
                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Paragraph(
                                text:
                                    "\t\t${idx + 1}. ${paper[index]['questions'][idx]['paragraph']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t\t1.\t${paper[index]['questions'][idx]['questions']['question1']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t\t2.\t${paper[index]['questions'][idx]['questions']['question2']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t\t3.\t${paper[index]['questions'][idx]['questions']['question3']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t\t4.\t${paper[index]['questions'][idx]['questions']['question4']}",style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Text(
                                "\t\t\t5.\t${paper[index]['questions'][idx]['questions']['question5']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                          ],
                        );
                      } else if (paper[index]['QuestionType'] == "type 81" ||
                          paper[index]['QuestionType'] == "type 89" ||
                          paper[index]['QuestionType'] == "type 90") {
                        // Passage reading/Case base MCQ questions

                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Paragraph(
                                text:
                                    "\t\t${idx + 1}. ${paper[index]['questions'][idx]['paragraph']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\t1.\t${paper[index]['questions'][idx]['questions'][0]['question']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\ta.\t${paper[index]['questions'][idx]['questions'][0]['optionA']} \t\t\tb.\t${paper[index]['questions'][idx]['questions'][0]['optionB']} \t\t\tc.\t${paper[index]['questions'][idx]['questions'][0]['optionC']} \t\t\td.\t${paper[index]['questions'][idx]['questions'][0]['optionD']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\t2.\t${paper[index]['questions'][idx]['questions'][1]['question']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\ta.\t${paper[index]['questions'][idx]['questions'][1]['optionA']} \t\t\tb.\t${paper[index]['questions'][idx]['questions'][1]['optionB']} \t\t\tc.\t${paper[index]['questions'][idx]['questions'][1]['optionC']} \t\t\td.\t${paper[index]['questions'][idx]['questions'][1]['optionD']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\t3.\t${paper[index]['questions'][idx]['questions'][2]['question']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\ta.\t${paper[index]['questions'][idx]['questions'][2]['optionA']} \t\t\tb.\t${paper[index]['questions'][idx]['questions'][2]['optionB']} \t\t\tc.\t${paper[index]['questions'][idx]['questions'][2]['optionC']} \t\t\td.\t${paper[index]['questions'][idx]['questions'][2]['optionD']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\t4.\t${paper[index]['questions'][idx]['questions'][3]['question']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\ta.\t${paper[index]['questions'][idx]['questions'][3]['optionA']} \t\t\tb.\t${paper[index]['questions'][idx]['questions'][3]['optionB']} \t\t\tc.\t${paper[index]['questions'][idx]['questions'][3]['optionC']} \t\t\td.\t${paper[index]['questions'][idx]['questions'][3]['optionD']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\t5.\t${paper[index]['questions'][idx]['questions'][4]['question']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                            pw.Text(
                                "\t\t\ta.\t${paper[index]['questions'][idx]['questions'][4]['optionA']} \t\t\tb.\t${paper[index]['questions'][idx]['questions'][4]['optionB']} \t\t\tc.\t${paper[index]['questions'][idx]['questions'][4]['optionC']} \t\t\td.\t${paper[index]['questions'][idx]['questions'][4]['optionD']}",
                                style:
                                    pw.TextStyle(fontFallback: [hindiFontTTF])),
                          ],
                        );
                      } else if (paper[index]['QuestionType'] == "type 10") {
                        print(paper[index]['questions'][idx]);
                        return pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("\t\t${idx + 1}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                            pw.Image(
                              images[paper[index]['questions'][idx]
                                  ['questionImgIndex']],
                              width: 200,
                              height: 200,
                            ),
                          ],
                        );
                      }
                      return pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              paper[index]['questions'][idx]['questionText'] !=
                                      ""
                                  ? pw.Text(
                                      "\t\t${idx + 1}. ${paper[index]['questions'][idx]['questionText']}", style: pw.TextStyle(fontFallback: [hindiFontTTF],))
                                  : pw.Text("\t\t${idx + 1}", style: pw.TextStyle(fontFallback: [hindiFontTTF],)),
                              paper[index]['questions'][idx]['questionText'] ==
                                      ""
                                  ? paper[index]['questions'][idx]
                                              ['questionImgIndex'] !=
                                          -1
                                      ? pw.Image(
                                          images[paper[index]['questions'][idx]
                                              ['questionImgIndex']],
                                          width: 200,
                                          height: 200)
                                      : pw.Container()
                                  : pw.Container(),
                            ],
                          ),
                          paper[index]['questions'][idx]['questionText'] !=
                                      "" &&
                                  paper[index]['questions'][idx]
                                          ['questionImgIndex'] !=
                                      -1
                              ? pw.Image(
                                  images[paper[index]['questions'][idx]
                                      ['questionImgIndex']],
                                  width: 200,
                                  height: 200)
                              : pw.Container()
                        ],
                      );
                    },
                  ),
                ]);
              },
            ),
          ),
        ],
      ),
    );
    return await doc.save();
  }
}
