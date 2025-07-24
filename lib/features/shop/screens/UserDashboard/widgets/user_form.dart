import 'package:education_web_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:education_web_admin_panel/features/shop/controller/user/createUser_controller.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/validators/validation.dart';

class TCreateUserForm extends StatelessWidget {
  const   TCreateUserForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateNewUserController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.createUserFormKey,
            child:Column(
            children:[
              const TSectionHeading(title:"Add New Users"),
                const SizedBox(height:TSizes.spaceBtwSections32 ),
              Row(
                  children:[
                ///  First Name TextField
                Expanded(
                    child: TextFormField(expands: false,controller:controller.firstName,
                        decoration:const InputDecoration(labelText:"First Name",prefixIcon:Icon(Iconsax.user)),
                      validator:(value) => TValidator.validateEmptyText("First Name",value),
                    )),
                const SizedBox(width:10),
      
                /// Last Name TextField
                Expanded(
                    child: TextFormField(expands: false,controller:controller.lastName,
                        decoration:const InputDecoration(labelText:"Last Name",prefixIcon:Icon(Iconsax.user)),
                      validator:(value) => TValidator.validateEmptyText("Last Name",value),
      
                    )),
              ]),
              const SizedBox(height:15),
      
              ///    Username TextField
              Row(
                children: [
                  Expanded(
                    child: TextFormField(expands:false,controller:controller.studentID,
                        decoration: const InputDecoration(labelText:"Student ID",prefixIcon:Icon(Iconsax.user_edit)),
                      validator:(value) => TValidator.validateEmptyText("Student ID",value),
                    )),
                  const SizedBox(width:16),
                  Expanded(
                    child:DropdownButtonFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.home),
                          labelText: "Student Batch"),
                      items: controller.batchesTypes.map((payType) {
                        return DropdownMenuItem(
                          value: payType,
                          child: Text (payType),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.batch.text = value!;
                      },
                      validator: (value) => TValidator.validateEmptyText("Student Batch", value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height:15),
      
              ///  E_Mail TextField
              TextFormField(expands:false,controller: controller.email,
                  decoration: const InputDecoration(labelText:"E-Mail",prefixIcon:Icon(Iconsax.direct)),
                validator:(value) => TValidator.validateEmail(value),
      
              ),
              const SizedBox(height:15),
      
              ///  Phone Number TextField
              TextFormField(expands:false,controller:controller.phoneNumber,
                  decoration: const InputDecoration(labelText:"Mobile Number",prefixIcon:Icon(Iconsax.call)),
                validator:(value) => TValidator.validatePhoneNumber(value),
      
              ),
              const SizedBox(height:15),
      
              ///  password  TextField
              Obx( ()=> TextFormField(expands:false,
                controller:controller.password,
                    obscureText:controller.hidePassword.value,
                    decoration:  InputDecoration(
                        labelText:"Password",
                        prefixIcon:const Icon(Iconsax.password_check),
                        suffixIcon:IconButton(
                            onPressed:() => controller.hidePassword.value = !controller.hidePassword.value,
                            icon:Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))
                    ),
                  validator:(value) => TValidator.validatePassword(value),
      
                ),
              ),
      
              const SizedBox(height:30),
      
              /// Sign Up Button Create Account button
              SizedBox(width:double.infinity, child:ElevatedButton(
                  onPressed:() => controller.createNewUser(),
                  child:const Text("Create New User")))
            ]
        )),
      ),
    );
  }
}
