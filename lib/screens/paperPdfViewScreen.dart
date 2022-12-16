// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/paper_generate_controller.dart';

import '../theme.dart';
import '../widgets/desktop_appbar.dart';
import '../widgets/side_layout.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PaperPDFViewScreen extends StatefulWidget {
  const PaperPDFViewScreen({Key? key}) : super(key: key);

  @override
  State<PaperPDFViewScreen> createState() => _PaperPDFViewScreenState();
}

class _PaperPDFViewScreenState extends State<PaperPDFViewScreen> {
  final PaperGenerateController paperGenerateController = Get.put(PaperGenerateController());
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: themeColor,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: deviceSize.width > 768
            ? PreferredSize(
                child: DesktopAppBar(),
                preferredSize: Size.fromHeight(70),
              )
            : AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
        drawer: deviceSize.width > 768
            ? Container()
            : Drawer(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: SideLayout(
                  pageIndex: 0,
                ),
              ),
        body: PdfPreview(
          maxPageWidth: 700,
          build: (format) => Get.find<PaperGenerateController>().generateDocument(format),
        ),
      ),
    );
  }
}
