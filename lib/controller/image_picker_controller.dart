import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;

import 'package:image_picker_web/image_picker_web.dart';

class ImagePickerController extends GetxController {
  final isLoading = false.obs;
  final isUploadedImage = false.obs;
  final uploadedImageUrl = "".obs;

  void pickImage() async {
    isUploadedImage.value = false;
    uploadedImageUrl.value = "";
    html.File? imageFile = await ImagePickerWeb.getImageAsFile();
    isLoading.value = true;

    if (imageFile == null) {
      isLoading.value = false;
      return;
    }

    var snapshot =
        await FirebaseStorage.instance.ref('images/').putBlob(imageFile);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    isLoading.value = false;
    isUploadedImage.value = true;
    uploadedImageUrl.value = downloadUrl;
  }
}
