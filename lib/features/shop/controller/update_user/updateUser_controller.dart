// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../../../../data/repositories/user/user_repository.dart';
// import '../../../authentication/controller/user_controller.dart';
//
// class UpdateUserController extends GetxController{
//   static UpdateUserController get instance => Get.find();
//
//
//   GlobalKey<FormState> updateUserFormKey = GlobalKey();
//
//   final userRepository = Get.put(UserRepository());
//   final userController = UserController.instance;
//
//   ///  INIT USER DATA WHEN HOME SCREEN APPEARS
//   @override
//   void onInit(){
//     initializeNames();
//     super.onInit();
//   }
//
//   /// FETCH USER RECORD
//   Future<void> initializeNames() async {
//     email.text = userController.user.value.email;
//     lastName.text = userController.user.value.lastName;
//     batch.text = userController.user.value.batch;
//     studentID. text= userController.user.value.studentId;
//     firstName.text = userController.user.value.firstName;
//     phoneNumber.text = userController.user.value.phoneNumber;
//   }
// }