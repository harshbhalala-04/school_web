import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html' as html;

class MultipleImageUploadController extends GetxController {
  final isLoading =
      [false.obs, false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  final isUploadedImage =
      [false.obs, false.obs, false.obs, false.obs, false.obs, false.obs].obs;
  final uploadedImageUrl = ["".obs, "".obs, "".obs, "".obs, "".obs, "".obs].obs;

  void pickImage(int index) async {
    isUploadedImage[index].value = false;
    uploadedImageUrl[index].value = "";
    html.File? imageFile = await ImagePickerWeb.getImageAsFile();
    isLoading[index].value = true;
    print(imageFile);
    if (imageFile == null) {
      isLoading[index].value = false;
      return;
    }

    var snapshot = await FirebaseStorage.instance
        .ref('images/${imageFile.name}')
        .putBlob(imageFile);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    isLoading[index].value = false;
    isUploadedImage[index].value = true;
    uploadedImageUrl[index].value = downloadUrl;
  }
}
