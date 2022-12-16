// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/controller/image_picker_controller.dart';
import 'package:school_web/controller/multiple_image_upload_controller.dart';

import '../theme.dart';

class ImageUploadButton extends StatefulWidget {
  bool fromMultiple;
  int index;
  ImageUploadButton({this.fromMultiple = false, this.index = -1});

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final MultipleImageUploadController multipleImgController =
      Get.put(MultipleImageUploadController());
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: buttonTheme),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            print("button clicked");
            if (widget.fromMultiple) {
              multipleImgController.pickImage(widget.index);
            } else {
              print("here pick iamge work");
              imagePickerController.pickImage();
            }
          },
          child: Text(
            "Upload Image",
            style: TextStyle(
                fontFamily: "calibri", fontSize: 20, color: Colors.white),
          ),
        ));
  }
}
