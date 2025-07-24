import 'package:education_web_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/files_controller.dart';



class TNotesScreen extends StatelessWidget {
  const TNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FilesController controller = Get.put(FilesController());


    return SingleChildScrollView(
      child: Column(
        children: [
          /// SECTION HEADING
          const TSectionHeading(title: "Upload Notes"),

          /// UPLOAD IMAGE AND SHOW IMAGE HERE
          const SizedBox(height: TSizes.spaceBtwSections32),

          Form(
            key: controller.uploadNotesKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.notesUrl,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.link),
                    labelText: "Enter UrlLink",
                  ),
                  validator: (value) => TValidator.validateEmptyText("Url Link", value),
                ),

                const SizedBox(height: TSizes.md16),

                /// TEXT FIELD FOR TITLE
                TextFormField(
                  controller: controller.notesTitle,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.arrow_right),
                    labelText: "Enter title",
                  ),
                  validator: (value) => TValidator.validateEmptyText("Title", value),
                ),
                const SizedBox(height: TSizes.md16),

                /// TEXT FIELD FOR SUBTITLE
                TextFormField(
                  controller: controller.notesSubtitle,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.arrow_right),
                    labelText: "Enter subtitle",
                  ),
                  validator: (value) => TValidator.validateEmptyText("Subtitle", value),
                ),
                const SizedBox(height: TSizes.md16),

                /// TEXT FIELD FOR BATCH
                DropdownButtonFormField(
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
                    controller.notesBatch.text = value!;
                  },
                  validator: (value) => TValidator.validateEmptyText("Student Batch", value),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections32),

          /// ELEVATED BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:()=> controller.uploadNotes(),
              child: const Text("Upload Notes"),
            ),
          ),
        ],
      ),
    );
  }
}