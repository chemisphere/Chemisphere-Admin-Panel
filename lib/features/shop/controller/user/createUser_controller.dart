import 'package:education_web_admin_panel/features/shop/models/creteUser_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';

  class CreateNewUserController extends GetxController{
  static CreateNewUserController get instance => Get.find();

  ///-----VARIABLES------
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final batch = TextEditingController();
  final studentID = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  List<String> batchesTypes = ['NEET11', 'NEET12', 'JEE11', "JEE12"];

  GlobalKey<FormState> createUserFormKey = GlobalKey();


  /// -----SIGNUP------
   void createNewUser() async {
     try {
       //START LOADING
       TFullScreenLoader.openLoadingDialog("Creating new user details",TImages.successfullyRegisterAnimation);

       ///CHECK INTERNET CONNECTIVITY
       final isConnected = await NetworkManager.instance.isConnected();
       if (!isConnected){
         TFullScreenLoader.stopLoading();
         return;
       }


       // FORM VALIDATION
       if (!createUserFormKey.currentState!.validate()){
         TFullScreenLoader.stopLoading();
         return;
       }

       //----REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE USER DATA IN THE FIREBASE
       final userCredential = await AuthenticationRepository.instance
           .registerWithEmailAndPassword(email.text.trim(), password.text.trim());


       //SAVE AUTHENTICATION USER DATA INT THE FIREBASE FIRESTORE
       final newUser = UserModel(
         id: userCredential.user!.uid,
         firstName: firstName.text.trim(),
         lastName: lastName.text.trim(),
         studentId: studentID.text.trim(),
         email: email.text.trim(),
         phoneNumber: phoneNumber.text.trim(),
         profilePicture: '',
         batch:batch.text.trim(),
       );

       final userRepository = Get.put(UserRepository());
       await userRepository.storeUserRecord(newUser);


       //REMOVE LOADER
       TFullScreenLoader.stopLoading();


       ///SHOW  SUCCESS MESSAGE
       TLoaders.successSnackBar(title: "Congratulation",message: "User Successfully crated");

       update();

       phoneNumber.clear();
       studentID.clear();
       email.clear();
       lastName.clear();
       batch.clear();
       firstName.clear();
       password.clear();

     }
    catch(e){
      // REMOVE LOADER
      TFullScreenLoader.stopLoading();
  // SHOW SOME GENERIC ERROR TO USER
      TLoaders.errorSnackBar(title:"Oh Snap!",message:"Something went wrong! Check your Network connection");
    }
  }
}