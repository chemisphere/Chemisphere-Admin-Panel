import 'package:education_web_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import '../../../data/banner/banner_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final BannerRepository _repository = BannerRepository();
  final titleController = TextEditingController();
  final targetScreenController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RxString _selectedImage = ''.obs;
  final Rx<html.File?> _selectedFile = Rx<html.File?>(null);
  final RxBool _active = false.obs;

  String get selectedImage => _selectedImage.value;
  bool get active => _active.value;

  void setSelectedImage(String imageDataUrl, html.File file) {
    _selectedImage.value = imageDataUrl;
    _selectedFile.value = file;
  }

  void setActive(bool value) {
    _active.value = value;
  }

  Future<void> uploadBanner() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog("Uploading Banner", TImages.successfullyRegisterAnimation);

      // FORM VALIDATION
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final file = _selectedFile.value;
      if (file == null) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Oh Snap!", message: "No file selected");
        return;
      }

      final title = titleController.value.text.trim();
      final uploadUrl = await _repository.uploadImage(file, title);

      // CREATE BANNER MODEL
      final bannerModel = BannerModel(
        imageUrl: uploadUrl,
        title: title,
        targetScreen: targetScreenController.value.text.trim(),
        active: active,
      );

      // UPLOAD BANNER TO FIRESTORE
      await _repository.uploadBanner(bannerModel);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(title: "Success", message: "Banner uploaded successfully");

      update();
      titleController.clear();
      targetScreenController.clear();
      _selectedImage.value = '';
      _selectedFile.value = null;
    } catch (e, stackTrace) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title: "Oh Snap!", message: "Something went wrong");

      // Print detailed error and stack trace
      print('Error: $e');
      print('StackTrace: $stackTrace');
    }
  }

  void selectImage() async {
    final html.InputElement input = html.InputElement(type: 'file');
    input.accept = 'image/*';
    input.click();

    await input.onChange.first.then((_) async {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final file = files.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(file);

        await reader.onLoad.first.then((_) {
          final imageDataUrl = reader.result as String;
          setSelectedImage(imageDataUrl, file);
        });
      }
    });
  }
}
