import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../../features/Files/models/banner_model.dart';
import '../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(html.File file, String title) async {
    try {
      final storageRef = storage.ref().child('Banners/$title.jpg');
      final uploadTask = storageRef.putBlob(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
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
    } catch (e,stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> uploadBanner(BannerModel bannerModel) async {
    try {
      await firestore.collection("Banners").add(bannerModel.toJson());
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
    } catch (e,stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
      throw "Something went wrong. Please try again";
    }
  }
}
