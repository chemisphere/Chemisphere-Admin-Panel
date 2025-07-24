import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';



class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// VARIABLES
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();


  ///SEND RESET PASSWORD EMAIL
 sendPasswordResetEmail() async{
   try{
     // START LOADING
     TFullScreenLoader.openLoadingDialog("Processing your request...",TImages.successfullyRegisterAnimation);

     // CHECK INTERNET CONNECTIVITY
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected){
       TFullScreenLoader.stopLoading();
       return;
     }

     // FORM VALIDATION
     if(!forgetPasswordFormKey.currentState!.validate()){
       TFullScreenLoader.stopLoading();
       return;
     }

     // SEND EMAIL TO RESET PASSWORD
     await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());


     //  REMOVE LOADER
     TFullScreenLoader.stopLoading();

     // SHOW SUCCESS SCREEN
     TLoaders.successSnackBar(title:"Email",message:"Email Link Sent to reset your Password");

     // REDIRECT
     Get.toNamed(TRoutes.resetPassword);

   }
   catch(e){
     TFullScreenLoader.stopLoading();
     TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
   }
 }

 resendPasswordResetEmail() async{
   try{
     // START LOADING
     TFullScreenLoader.openLoadingDialog("Processing your request...",TImages.successfullyRegisterAnimation);

     // CHECK INTERNET CONNECTIVITY
     final isConnected = await NetworkManager.instance.isConnected();
     if(!isConnected){
       TFullScreenLoader.stopLoading();
       return;
     }

     // SEND EMAIL TO RESET PASSWORD
     await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());


     //  REMOVE LOADER
     TFullScreenLoader.stopLoading();

     // SHOW SUCCESS SCREEN
     TLoaders.successSnackBar(title:"Email",message:"Email Link Sent to reset your Password");

   }
   catch(e){
     TFullScreenLoader.stopLoading();
     TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
   }
 }

}