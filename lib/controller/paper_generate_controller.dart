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
        // print(singleQuestionSetQuestionsList);
      }
      // print("here single question set added");
      print(singleQuestionSetQuestionsList);

      for (int i = 0; i < singleQuestionSetQuestionsList.length; i++) {
        if (blueprints[idx].questionSet[i]['QuestionType'] == "type 38") {
          //Pictograph
          final netImage =
              await networkImage(singleQuestionSetQuestionsList[i]['paraImg']);
          images.add(netImage);
          int idx = images.indexWhere((element) => element == netImage);
          singleQuestionSetQuestionsList[i]['paraImgIndex'] = idx;
        } else if (blueprints[idx].questionSet[i]['QuestionType'] ==
            "type 29") {
          //Mcq question
          if (singleQuestionSetQuestionsList[i]['questionImg'] != "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[i]['questionImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['questionImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['questionImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[i]['optionAImg'] != "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[i]['optionAImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['optionAImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['optionAImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[i]['optionBImg'] != "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[i]['optionBImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['optionBImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['optionBImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[i]['optionCImg'] != "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[i]['optionCImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['optionCImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['optionCImgIndex'] = -1;
          }

          if (singleQuestionSetQuestionsList[i]['optionDImg'] != "") {
            final netImage = await networkImage(
                singleQuestionSetQuestionsList[i]['optionDImg']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['optionDImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['optionDImgIndex'] = -1;
          }
        } else if (blueprints[idx].questionSet[i]['QuestionType'] ==
                "type 22" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 32" ||
            blueprints[idx].questionSet[i]['QuestionType'] == "type 74") {
          //match the picture of obj with name question
          continue;
        } else {
          //Description of img, Graph, map, maths, image only question & all other questions
          if (singleQuestionSetQuestionsList[i]['imgUrl'] != "") {
            final netImage =
                await networkImage(singleQuestionSetQuestionsList[i]['imgUrl']);
            images.add(netImage);
            int idx = images.indexWhere((element) => element == netImage);
            singleQuestionSetQuestionsList[i]['questionImgIndex'] = idx;
          } else {
            singleQuestionSetQuestionsList[i]['questionImgIndex'] = -1;
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
    final mapImage = await networkImage(
        "https://firebasestorage.googleapis.com/v0/b/sxcmi-97533.appspot.com/o/india-map.jpg?alt=media&token=62ac7316-eca1-4522-982a-0e914d2b73ce");
    final netImage = await networkImage(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDMAL5hxrBGQ-QKZv2DlB0hDRMRb0YPBnUgA&usqp=CAU");
    final netImage2 = await networkImage(
        "https://firebasestorage.googleapis.com/v0/b/sxcmi-97533.appspot.com/o/images?alt=media&token=520f2a13-f2b3-474a-adae-d3afc4d655c0");
    var assetImage = pw.MemoryImage(
      (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List(),
    );

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
                              font: font4,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                          pw.Text(
                            "Half Yearly Exam(september-2022)",
                            style: pw.TextStyle(
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
                        if (idx == 0) {
                          return pw.Table.fromTextArray(
                              context: _, data: overAllList);
                        }
                        return pw.Container();
                      } else if (paper[index]['QuestionType'] == "type 74") {
                        if (idx == 0) {
                          return pw.Table.fromTextArray(
                              context: _, data: overAll74List);
                        }
                        return pw.Container();
                      } else if (paper[index]['QuestionType'] == "type 38") {
                        return pw.Image(images[paper[index]['questions'][idx]
                            ['paraImgIndex']]);
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
                            : pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Image(
                                      images[paper[index]['questions'][idx]
                                          ['questionImgIndex']],
                                      width: 300,
                                      height: 300)
                                ],
                              );
                        // return pw.Row(
                        //   mainAxisAlignment: pw.MainAxisAlignment.start,
                        //   children: [
                        //     pw.Column(
                        //       crossAxisAlignment: pw.CrossAxisAlignment.start,
                        //       children: [
                        //         pw.Text(
                        //           "${idx + 1}.",
                        //           style: pw.TextStyle(
                        //             color: PdfColors.black,
                        //             fontSize: 14,
                        //             font: font3,
                        //           ),
                        //         ),
                        //         paper[index]['questions'][idx]
                        //                     ['questionImgIndex'] ==
                        //                 -1
                        //             ? pw.Container()
                        //             : pw.Image(images[paper[index]['questions']
                        //                 [idx]['questionImgIndex']]),
                        //         paper[index]['questions'][idx]['questionText'] !=
                        //                 ""
                        //             ? pw.Text(paper[index]['questions'][idx]
                        //                 ['questionText'])
                        //             : pw.Container(),
                        //       ],
                        //     ),
                        //   ],
                        // );
                      } else if (paper[index]['QuestionType'] == "type 29") {
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
                                pw.SizedBox(height: 2),
                                pw.Text(
                                  "\t\t\ta)\t${paper[index]['questions'][idx]['optionA']}\t\tb)\t${paper[index]['questions'][idx]['optionB']}\t\tc)\t${paper[index]['questions'][idx]['optionC']}\t\td)\t${paper[index]['questions'][idx]['optionD']}",
                                  style: pw.TextStyle(
                                    color: PdfColors.black,
                                    fontSize: 14,
                                    font: font3,
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 3),
                          ],
                        );
                      }
                      return pw.Row(
                        children: [
                          pw.Text(
                              "\t\t${idx + 1}. ${paper[index]['questions'][idx]['questionText']}"),
                        ],
                      );
                    },
                  ),
                ]);
              },
            ),

            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.1",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tMultiple choice questions",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 10),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t1.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThe Milkyway is ____________",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Text(
            //       "\t\t\ta)\tOption1\t\tb)\tOption2\t\tc)\tOption3\t\td)\tOption4",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 10),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t2.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text:
            //                 "\tTime taken by the earth to make one revolution around the sun is __________.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Text(
            //       "\t\t\ta)\tOption1\t\tb)\tOption2\t\tc)\tOption3\t\td)\tOption4",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 10),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t3.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tPick Correct image from the following____________",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Row(
            //       children: [
            //         pw.Text("\t\ta)\t"),
            //         pw.Image(netImage, height: 100, width: 100),
            //         pw.SizedBox(width: 5),
            //         pw.Text("\t\tb)\t"),
            //         pw.Image(netImage, height: 100, width: 100),
            //         pw.SizedBox(width: 5),
            //         pw.Text("\t\tc)\t"),
            //         pw.Image(netImage, height: 100, width: 100),
            //         pw.SizedBox(width: 5),
            //         pw.Text("\t\td)\t"),
            //         pw.Image(netImage, height: 100, width: 100),
            //         pw.SizedBox(width: 5),
            //       ],
            //     ),
            //     pw.SizedBox(height: 20),
            //     /*Completed 1 Question set*/

            //     // 2nd question set start for all descriptive 2,3,4, true false, fill in the blanks all types//
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.2",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tFill in the blanks",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 10),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t1.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\t_________ planet does not spin upright.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t2.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tHe hunted animals for _________and __________.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t3.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text:
            //                 "\tWant of one person may be ___________ from that of another.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Row(
            //       children: [
            //         pw.Text(
            //           "\t\t4.",
            //           style: pw.TextStyle(
            //             color: PdfColors.black,
            //             fontSize: 14,
            //             font: font3,
            //           ),
            //         ),
            //         pw.Image(netImage2),
            //       ],
            //     ),
            //     pw.SizedBox(height: 20),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.3",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tMap Question",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.Image(mapImage, height: 400, width: 400),
            //     pw.SizedBox(height: 10),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t1.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is map based question",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 20),
            //     // Case base questions & MCQs
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.4",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tCase base questions",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.Paragraph(
            //       text:
            //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t1.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base question 1",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t2.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base question 2",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t3.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base question 3",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 20),
            //     // case base mcqs
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.5",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tCase base MCQs",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.Paragraph(
            //       text:
            //           "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t1.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base mcq 1",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Text(
            //       "\t\t\ta)\tOption1\t\tb)\tOption2\t\tc)\tOption3\t\td)\tOption4",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t2.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base mcq 2",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Text(
            //       "\t\t\ta)\tOption1\t\tb)\tOption2\t\tc)\tOption3\t\td)\tOption4",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "\t\t3.",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tThis is case base mcq 3",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 14,
            //               font: font3,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 5),
            //     pw.Text(
            //       "\t\t\ta)\tOption1\t\tb)\tOption2\t\tc)\tOption3\t\td)\tOption4",
            //       style: pw.TextStyle(
            //         color: PdfColors.black,
            //         fontSize: 14,
            //         font: font3,
            //       ),
            //     ),
            //     pw.SizedBox(height: 20),
            //     // Match the following question set
            //     pw.RichText(
            //       text: pw.TextSpan(
            //         children: [
            //           pw.TextSpan(
            //             text: "Q.6",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //           pw.TextSpan(
            //             text: "\tMatch the following",
            //             style: pw.TextStyle(
            //               color: PdfColors.black,
            //               fontSize: 16,
            //               font: font4,
            //               fontWeight: pw.FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     pw.SizedBox(height: 10),
            //     pw.Table.fromTextArray(
            //       context: context,
            //       data: const <List<String>>[
            //         <String>['A', 'B'],
            //         <String>['1\t\tMars', 'A\t\tBanks of river Yamuna'],
            //         <String>['2\t\tAfrica', 'B\t\tIsland Continent'],
            //         <String>['3\t\tAustralia', 'C\t\tRed Planet'],
            //         <String>['4\t\tRaj Ghat', 'D\t\tPeninsular part of India'],
            //         <String>['5\t\tThe Deccan Plateau', 'E\t\tApril or May'],
            //         <String>['6\t\tBuddha Poornima', 'F\t\tDark Continent'],
            //       ],
            //     ),
            //     pw.Padding(padding: const pw.EdgeInsets.all(10)),
          ),
        ],
      ),
    );
    return await doc.save();
  }
}
