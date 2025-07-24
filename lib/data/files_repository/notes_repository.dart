import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_web_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../features/Files/models/file_model.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class FilesRepository extends GetxController {
  static FilesRepository get instance => Get.find();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;



  Future<void> uploadNotesFile(FileModel fileModel) async {
    try {
      await firestore.collection("Notes").add(fileModel.toJson());

    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> uploadPYQSFile(FileModel fileModel) async {
    try {
      await firestore.collection("PYQS").add(fileModel.toJson());

    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }


}
