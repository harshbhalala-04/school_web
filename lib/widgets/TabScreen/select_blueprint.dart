// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/controller/paper_generate_controller.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/desktop_appbar.dart';

import '../footer.dart';
import '../side_layout.dart';

class SelectBlueprint extends StatefulWidget {
  const SelectBlueprint({super.key});

  @override
  State<SelectBlueprint> createState() => _SelectBlueprintState();
}

class _SelectBlueprintState extends State<SelectBlueprint> {
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());
  @override
  void initState() {
    paperGenerateController.getBlueprint(
        className: paperGenerateController.className,
        subjectName: paperGenerateController.subjectName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [blueprintlistviewmodel()],
    );
  }
}

class blueprintlistviewmodel extends StatefulWidget {
  const blueprintlistviewmodel({super.key});

  @override
  State<blueprintlistviewmodel> createState() => _blueprintlistviewmodelState();
}

class _blueprintlistviewmodelState extends State<blueprintlistviewmodel> {
  final PaperGenerateController paperGenerateController =
      Get.put(PaperGenerateController());
  @override
  void initState() {
    paperGenerateController.getBlueprint(
        className: paperGenerateController.className,
        subjectName: paperGenerateController.subjectName);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DataRow> _testRows = [
      const DataRow(
        cells: [
          // DataCell(
          //   ListView.builder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: 1,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Text(index.toString());
          //     },
          //   ),
          // ),
          DataCell(
            Text('Data A'),
          ),
          DataCell(
            Text('Data B'),
          ),
          DataCell(
            Text('Data C'),
          ),
          DataCell(
            Text('Data D'),
          ),
          DataCell(
            Text('Data E'),
          ),
          
        ],
      ),
    ];

    return Form(
      child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.only(left: 80, right: 80),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DataTable(columns: const [
                  DataColumn(
                      label: Text('Question Type',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Subject',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('BluePrint Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Action',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ], rows: _testRows),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
