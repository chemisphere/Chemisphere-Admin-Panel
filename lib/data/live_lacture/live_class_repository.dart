import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class LiveLactureRepository extends GetxController {
  static LiveLactureRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadLiveLacture(String liveClassUrl, String batch) async {
    try {
      await _firestore.collection('LiveClasses').add({
        'Link': liveClassUrl,
        'batch': batch.toString(),
      });
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.code}');
      throw TFirebaseException(e.code).message;
    } on FormatException catch (e) {
      print('FormatException: $e');
      throw const TFormatException();
    } on PlatformException catch (e) {
      print('PlatformException: ${e.code}');
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('Error: $e');
      throw "Something went wrong. Please try again";
    }
  }
}