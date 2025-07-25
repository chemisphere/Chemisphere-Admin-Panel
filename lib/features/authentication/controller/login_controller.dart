import 'package:education_web_admin_panel/features/authentication/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/admin_model.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();


  @override
  void onInit(){
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ??'';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ??'';
    super.onInit();
  }

  /// HANDLES EMAIL AND PASSWORD SIGN IN PROCESS
  Future<void> emailAndPasswordSignIn() async{
    try{
      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Login Admin Account...", TImages.docerAnimation);

      /// CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// FORM VALIDATION
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }


      // SAVE DATA IF REMMBER ME IS SELECTED
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL',email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD',password.text.trim());
      }


      /// login USER USING EMAIL & PASSWORD AUTHENTICATIONS
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(),password.text.trim());


      /// FETCH USER DETAILS AND ASSIGN TO USER CONTROLLER
      final user = await UserController.instance.adminDetails();

      /// REMOVE THE LOADER
      TFullScreenLoader.stopLoading();

      // IF USER IS NOT ADMIN, LOGOUT AND RETURN
      if(user.role != AppRole.admin){
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(title:"Not Authorized",message:"You are not authorized or do have access. Contact Admin");
      }else{
        AuthenticationRepository.instance.screenRedirect();
      }
    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
  }


  /// HANDLES REGISTRATION OF ADMIN USER
  Future<void> registerAdmin()async{
    try{
      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Registration Admin Account...", TImages.docerAnimation);

      /// CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// FORM VALIDATION
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }




      /// REGISTER USER USING EMAIL & PASSWORD AUTHENTICATIONS
      await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(),password.text.trim());


      ///  CREATE ADMIN RECORD IN THE FIRESTORE
      final userRepository = Get.put(UserRepository());
      await userRepository.storeAdminRecord(
        AdminModel(
          id:AuthenticationRepository.instance.authUser!.uid,
          email:email.text.trim(),
          firstName:"Aryan",
          lastName: "Panchal",
          role: AppRole.admin,
          createdAt:DateTime.now(),
          phoneNumber: '8080737803',
        ),
      );

      /// REMOVE THE LOADER
      TFullScreenLoader.stopLoading();

      ///  REDIRECT
      AuthenticationRepository.instance.screenRedirect();

    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
  }

}