import 'package:education_web_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:education_web_admin_panel/utils/constants/image_strings.dart';
import 'package:education_web_admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../data/repositories/user/user_repository.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/network_manager.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../models/creteUser_model.dart';



class UpdateUserDetailPopup extends StatelessWidget {
  const UpdateUserDetailPopup({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController(text:user.email);
    final lastName = TextEditingController(text:user.lastName);
    final batch = TextEditingController(text:user.batch);
    final studentID = TextEditingController(text:user.studentId);
    final firstName = TextEditingController(text:user.firstName);
    final phoneNumber = TextEditingController(text:user.phoneNumber);
    GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();


    /// EDIT USER DETAILS HARE
    Future<void> updateUserDetails() async{
      try{
        /// START LOADING
        TFullScreenLoader.openLoadingDialog("We are updating your information...",TImages.congratulationAnimation);

        /// CHECK INTERNET CONNECTIVITY
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          TFullScreenLoader.stopLoading();
          return;
        }

        /// FORM VALIDATION
        if(!updateUserNameFormKey.currentState!.validate()){
          TFullScreenLoader.stopLoading();
          return;
        }

        /// SAVE USER DETAILS IN THE FIREBASE FiRE STORE
        final newUser = UserModel(
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          studentId: studentID.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture:user.profilePicture,
          batch:batch.text.trim(),
          id:user.id,
        );

        /// USER DATA STORE METHOD HARE
        final userRepository = Get.put(UserRepository());
        await userRepository.storeUserRecord(newUser);

        ///  REMOVE LOADER
        TFullScreenLoader.stopLoading();
        /// SHOW SUCCESS MESSAGE
        TLoaders.successSnackBar(title:"Congratulations",message:"User details successfully updated.");
        // Get.back();
      }
      catch(e){
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title:"Oh snap",message:e.toString());
      }
    }

    return SingleChildScrollView(
        child:Dialog(
          /// DEFINE THE SHAPE OF THE DIALOG
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(TSizes.borderRadiusLg12)),
            child:TRoundedContainer(
              /// SET THE WIDTH OF THE ROUNDS BASE ON THE SCREEN SIZE
                width:TDeviceUtils.isDesktopScreen(context) ? MediaQuery.of(context).size.width* 0.5 : double.infinity,
                padding:const EdgeInsets.all(TSizes.spaceBtwItems16),
              child: Form(
                key:updateUserNameFormKey,
                  child:Column(
                      children:[
                         Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            const TSectionHeading(title:"Edit User Details"),
                            IconButton(onPressed:()=>Get.back(), icon:const Icon(Iconsax.close_circle),color:Colors.red)
                          ],
                        ),
                        const SizedBox(height:TSizes.spaceBtwSections32 ),
                        Row(
                            children:[
                              ///  First Name TextField
                              Expanded(
                                  child: TextFormField(expands: false,controller:firstName,
                                    decoration:const InputDecoration(labelText:"First Name",prefixIcon:Icon(Iconsax.user)),
                                    validator:(value) => TValidator.validateEmptyText("First Name",value),
                                  )),
                              const SizedBox(width:10),

                              /// Last Name TextField
                               Expanded(
                                  child: TextFormField(expands: false,controller:lastName,
                                    decoration:const InputDecoration(labelText:"Last Name",prefixIcon:Icon(Iconsax.user)),
                                    validator:(value) => TValidator.validateEmptyText("Last Name",value),

                                  )),
                            ]),
                        const SizedBox(height:15),

                        ///    Username TextField
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(expands:false,controller:studentID,
                                  decoration: const InputDecoration(labelText:"Student ID",prefixIcon:Icon(Iconsax.user_edit)),
                                  validator:(value) => TValidator.validateEmptyText("Student ID",value),
                                )),
                            const SizedBox(width:16),
                            Expanded(
                                child: TextFormField(expands:false,controller:batch,
                                  decoration: const InputDecoration(labelText:"Batch  ",prefixIcon:Icon(Iconsax.user_edit)),
                                  validator:(value) => TValidator.validateEmptyText("Batch",value),
                                )),
                          ],
                        ),
                        const SizedBox(height:15),

                        ///  E_Mail TextField
                        TextFormField(expands:false,controller:email,
                          decoration: const InputDecoration(labelText:"E-Mail",prefixIcon:Icon(Iconsax.direct)),
                          validator:(value) => TValidator.validateEmail(value),

                        ),
                        const SizedBox(height:15),

                        ///  Phone Number TextField
                        TextFormField(expands:false,controller:phoneNumber,
                          decoration: const InputDecoration(labelText:"Mobile Number",prefixIcon:Icon(Iconsax.call)),
                          validator:(value) => TValidator.validatePhoneNumber(value),
                        ),


                        const SizedBox(height:30),
                        /// Sign Up Button Create Account button
                        SizedBox(width:double.infinity, child:ElevatedButton(
                            onPressed:()=>TDialogs.defaultDialog(context:Get.context!,
                                content: "Are you sure want to Edit this Details",
                                confirmText:"Update",
                                onConfirm: (){
                                  /// CLOSE THE PREVIOUS DIALOG IMAGE POPUP
                                  Get.back();
                                  updateUserDetails();
                                }
                            ),
                            child:const Text("Edit User")))
                      ]
                  )),

            )
        )
    );
  }
}
