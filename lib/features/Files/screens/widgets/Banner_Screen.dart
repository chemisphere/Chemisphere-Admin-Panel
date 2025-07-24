import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:universal_html/html.dart'as html;
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/banner_controller.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    return SingleChildScrollView(
      child: Column(
        children: [
          // SECTION HEADING
          const TSectionHeading(title: "Upload Banner"),
          const SizedBox(height: TSizes.spaceBtwItems16),

          // SELECT BANNER FROM THE GALLERY
          TRoundedContainer(
            width: 200,
            height: 100,
            showBorder: true,
            onTap: bannerController.selectImage,
            child: Obx(() {
              return bannerController.selectedImage.isNotEmpty
                  ? Image.network(bannerController.selectedImage)
                  : Image.asset(TImages.defaultImage, fit: BoxFit.contain);
            }),
          ),

          const SizedBox(height: TSizes.md16),
          Form(
            key: bannerController.formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.link),
                    labelText: "Enter PYQ Link",
                  ),
                  validator: (value) => TValidator.validateEmptyText("Link", value),
                  controller: bannerController.targetScreenController,
                ),

                const SizedBox(height: TSizes.md16),

                // TEXT FIELD FOR TITLE
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.arrow_right),
                    labelText: "Enter title",
                  ),
                  validator: (value) => TValidator.validateEmptyText("Title", value),
                  controller: bannerController.titleController,
                ),

                const SizedBox(height: TSizes.spaceBtwItems16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: bannerController.active,
                        onChanged: (value) {
                          if (value != null) {
                            bannerController.setActive(value);
                          }
                        },
                      );
                    }),
                    const Text("Active"),
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwItems16),
                // ELEVATED BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: bannerController.uploadBanner,
                    child: const Text("Upload Banner"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
