import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_web_admin_panel/features/shop/models/creteUser_model.dart';
import 'package:education_web_admin_panel/utils/constants/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/authentication/models/admin_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repositories.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();


  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// FUNCTION TO STORE USER DATA TO FiRESTORE
  Future<void> storeUserRecord(UserModel user) async{
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  /// ==== STORING ADMIN RECORD IN THE FIREBASE
  Future<void> storeAdminRecord(AdminModel user) async{
    try{
      await _db.collection("Admin").doc(user.id).set(user.toJson());
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

  /// FUNCTION TO FETCH USER AND ADMIN DETAILS ON USER ID
  Future<AdminModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _db.collection("Admin").doc(AuthenticationRepository.instance.authUser!.uid).get();
      if (docSnapshot.exists && docSnapshot.data()!['Role'] == 'admin') {
        return AdminModel.fromSnapshot(docSnapshot);
      } else {
        throw "User is not an admin";
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }


  /// FETCH THE  IMAGE FROM THE FIREBASE FIRE STORE STORAGE
  Future<List<UserModel>> fetchBatchUsersFromDatabase(Batch userBatches)async{
    try{
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Users").where("Batch",isEqualTo:userBatches.name.toString())
          .get();

      return querySnapshot.docs.map((e)=> UserModel.fromSnapshot(e)).toList();
    }
    on FirebaseException catch(e){
      throw e.message!;
    } on SocketException catch(e){
      throw e.message;
    } on PlatformException catch(e){
      throw e.message!;
    }
    catch(e){
      throw e.toString();
    }
  }
}