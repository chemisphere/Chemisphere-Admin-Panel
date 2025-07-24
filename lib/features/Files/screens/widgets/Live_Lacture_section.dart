import 'package:education_web_admin_panel/features/Files/controller/Live_Lacture_Controller.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/validators/validation.dart';

class TLiveLactureSection extends StatelessWidget {
  const TLiveLactureSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lactureController = Get.put(LiveLactureController());
    return TRoundedContainer(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.link),
                labelText: "Live class Url",
              ),
              validator: (value) => TValidator.validateEmptyText("link", value),
             controller: lactureController.liveclassEditeingController,
            ),
          ),
          const SizedBox(width: TSizes.ms12),
          Expanded(
            child:DropdownButtonFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.home),
                  labelText: "Student Batch"),
              items: lactureController.batchesTypes.map((payType) {
                return DropdownMenuItem(
                  value: payType,
                  child: Text (payType),
                );
              }).toList(),
              onChanged: (value) {
                lactureController.batchEditingController.text = value!;
              },
              validator: (value) => TValidator.validateEmptyText("Student Batch", value),
            ),
          ),
          const SizedBox(width: TSizes.spaceBtwSections32),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: lactureController.updateLiveLacture,
              child: const Text("Update"),
            ),
          ),
        ],
      ),
    );
  }
}
