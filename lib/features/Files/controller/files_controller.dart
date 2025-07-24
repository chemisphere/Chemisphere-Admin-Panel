import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/files_repository/notes_repository.dart';
import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/file_model.dart';

class FilesController extends GetxController {
  final FilesRepository _repository = FilesRepository();
  final notesUrl = TextEditingController();
  final notesTitle = TextEditingController();
  final notesSubtitle = TextEditingController();
  final notesBatch = TextEditingController();

  final pyqsUrl = TextEditingController();
  final pyqsTitle = TextEditingController();
  final pyqsSubtitle = TextEditingController();
  final pyqsBatch = TextEditingController();
  GlobalKey<FormState> uploadNotesKey = GlobalKey();
  GlobalKey<FormState> uploadPYQSKey = GlobalKey();


  List<String> batchesTypes = ['NEET11', 'NEET12', 'JEE11', "JEE12"];


  void uploadNotes() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog("Uploading Notes File", TImages.successfullyRegisterAnimation);


      // FORM VALIDATION
      // FORM VALIDATION
      if (!uploadNotesKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance;

      //CREATE FILE MODEL
      FileModel fileModel = FileModel(
        batch: notesBatch.text.trim(),
        title: notesTitle.text.trim(),
        subtitle: notesSubtitle.text.trim(),
        fileUrl: notesUrl.text,
        id:userCredential.authUser!.uid,
      );

      //UPLOAD FILE TO FIREBASE
      await _repository.uploadNotesFile(fileModel);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      ///SHOW  SUCCESS MESSAGE
      TLoaders.successSnackBar(title: "Success", message: "Notes uploaded successfully");

      update();

      notesUrl.clear();
      notesTitle.clear();
      notesSubtitle.clear();
      notesBatch.clear();
    } catch (e) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title: "Oh Snap!", message: "Something went wrong! Check your Network connection");
    }
  }

  void uploadPYQS() async {
    try {
      //START LOADING
      TFullScreenLoader.openLoadingDialog("Uploading PYQS File", TImages.successfullyRegisterAnimation);

      ///CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      // FORM VALIDATION
      // FORM VALIDATION
      if (!uploadPYQSKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance;

      //CREATE FILE MODEL
      FileModel fileModel = FileModel(
        batch: pyqsBatch.text.trim(),
        title: pyqsTitle.text.trim(),
        subtitle: pyqsSubtitle.text.trim(),
        fileUrl: pyqsUrl.text,
        id:userCredential.authUser!.uid,
      );

      //UPLOAD FILE TO FIREBASE
      await _repository.uploadPYQSFile(fileModel);

      //REMOVE LOADER
      TFullScreenLoader.stopLoading();

      ///SHOW  SUCCESS MESSAGE
      TLoaders.successSnackBar(title: "Success", message: "PYQS uploaded successfully");

      update();

      pyqsTitle.clear();
      pyqsSubtitle.clear();
      pyqsBatch.clear();
      pyqsUrl.clear();
    } catch (e) {
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
      // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title: "Oh Snap!", message: "Something went wrong! Check your Network connection");
    }
  }

}