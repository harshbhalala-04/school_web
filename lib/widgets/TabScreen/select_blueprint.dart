import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:school_web/controller/paper_generate_controller.dart';

class SelectBlueprint extends StatefulWidget {
  const SelectBlueprint({super.key});

  @override
  State<SelectBlueprint> createState() => _SelectBlueprintState();
}

class _SelectBlueprintState extends State<SelectBlueprint> {
  final PaperGenerateController  paperGenerateController=
        Get.put(PaperGenerateController());
  @override
  void initState() {
    paperGenerateController.getBlueprint(className: paperGenerateController.className,subjectName: paperGenerateController.subjectName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
