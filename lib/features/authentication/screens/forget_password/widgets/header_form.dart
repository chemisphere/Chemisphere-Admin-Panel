import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/forget_password_controller.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          /// HEADER
          IconButton(onPressed:()=> Get.offAllNamed(TRoutes.login), icon:const Icon(Iconsax.arrow_left)),
          const SizedBox(height:TSizes.spaceBtwItems16),
          Text(TTexts.forgetPasswordTitle,style:Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height:TSizes.spaceBtwItems16),
          Text(TTexts.forgetPasswordSubTitle,style:Theme.of(context).textTheme.labelMedium),
          const SizedBox(height:TSizes.spaceBtwItems16),

          /// FORM
          Form(child:TextFormField(
            controller:controller.email,
              decoration:const InputDecoration(
                  labelText:TTexts.email,
                  prefixIcon:Icon(Iconsax.direct_right))
          )),
          const SizedBox(height:TSizes.spaceBtwItems16),

          /// SUBMIT BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:()=> controller.sendPasswordResetEmail(),
                child:const Text("Submit")),
          ),const SizedBox(height:TSizes.spaceBtwItems16/2),
        ]
    );
  }
}
