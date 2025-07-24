import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/live_lacture/live_class_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class LiveLactureController extends GetxController {
  static LiveLactureController get instance => Get.find();

  ///-----VARIABLES------
  final liveclassEditeingController = TextEditingController();
  final batchEditingController = TextEditingController();

  List<String> batchesTypes = ['NEET11', 'NEET12', 'JEE11', "JEE12"];




  void updateLiveLacture() async {
    try {
      // START LOADING
      TFullScreenLoader.openLoadingDialog("Uploading Live Lacture", TImages.successfullyRegisterAnimation);

      final url = liveclassEditeingController.value.text.trim();
      final batch = batchEditingController.value.text.trim();

      if (url.isEmpty && batch.isEmpty) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: "Oh Snap!", message: "Enter valide data");
        return;
      }



      final liveClassRepository = Get.put(LiveLactureRepository());
      await liveClassRepository.uploadLiveLacture(url,batch);

      // REMOVE LOADER
      TFullScreenLoader.stopLoading();

      // SHOW SUCCESS MESSAGE
      TLoaders.successSnackBar(title: "Success", message: "Live Lacture uploaded successfully");


      /// CLEA SELECTED VALUE
      liveclassEditeingController.clear();
      batchEditingController.clear();

    } catch (e, stackTrace) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // Print detailed error and stack trace
      print('Error: $e');
      print('StackTrace: $stackTrace');
      // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title: "Oh Snap!", message: "Something went wrong! Check your Network connection");
    }
  }
}