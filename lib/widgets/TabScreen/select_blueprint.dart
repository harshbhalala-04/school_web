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
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return blueprintlistviewmodel();
      },
    );
  }
}

class blueprintlistviewmodel extends StatelessWidget {
  const blueprintlistviewmodel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
