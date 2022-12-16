import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImagePickerController extends GetxController {
  final isLoading = false.obs;
  final isUploadedImage = false.obs;
  final uploadedImageUrl = "".obs;

  void pickImage() async {
    isUploadedImage.value = false;
    uploadedImageUrl.value = "";
    // final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    html.File? imageFile = await ImagePickerWeb.getImageAsFile();
    print(imageFile);
    isLoading.value = true;
    print("here val");
    if (imageFile == null) {
      print("here false");
      isLoading.value = false;
      return;
    }
    print("here file: $imageFile");
    var snapshot =
        await FirebaseStorage.instance.ref('images/${imageFile.name}').putBlob(imageFile);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    isLoading.value = false;
    isUploadedImage.value = true;
    uploadedImageUrl.value = downloadUrl;
    
  }
}
