import 'package:education_web_admin_panel/utils/constants/enums.dart';
import 'package:education_web_admin_panel/utils/constants/image_strings.dart';
import 'package:education_web_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:education_web_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:education_web_admin_panel/features/authentication/controller/user_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/popups/dialogs.dart';
import '../../../models/creteUser_model.dart';
import 'batches_dropdown.dart';
import 'update_user_detail.dart';

class TFetchUserBatchRecord extends StatelessWidget {
  const TFetchUserBatchRecord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.find<UserController>();

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// TSECTIOIN HEADING HARE
              const TSectionHeading(title: "User Details"),

              /// ===== BATCHES DROPDOWN HARE =======
              BatchesDropdown(onChanged: (Batch? newSelectedBatch) {
                if (newSelectedBatch != null) {
                  controller.batchPath.value = newSelectedBatch;
                  controller.getBatchWiseUserData();
                }
              }),
            ],
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemBuilder: (context, index) {
                UserModel user = controller.users.value[index]; 
                if(user == null){
                  const Text("No Users record");
                }
                return Card(
                child: ListTile(
                  leading:CircleAvatar(backgroundImage:
                  user.profilePicture.isNotEmpty ?NetworkImage(user.profilePicture): const AssetImage(TImages.user)),
                  title: Text(user.fullName,style: Theme.of(context).textTheme.headlineSmall!.apply(overflow:TextOverflow.ellipsis)),
                  subtitle: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text("Student ID: ${user.studentId}",style: Theme.of(context).textTheme.bodySmall!.apply(overflow:TextOverflow.ellipsis)),
                      const SizedBox(width:TSizes.ms12),
                      Text("Batch: ${user.batch}",style: Theme.of(context).textTheme.bodySmall!.apply(overflow:TextOverflow.ellipsis)),
                    ],
                  ),
                  trailing:const Icon(Iconsax.arrow_right),

                  /// UPDATE USER METHOD HARE ON TAP
                  onTap:()=> Get.dialog(UpdateUserDetailPopup(user:user)),
                  onLongPress:()=> TDialogs.defaultDialog(context:Get.context!,
                      content: "Are you sure want to Delete this User",
                      onConfirm: (){Get.back();}),
                ),
              );
                },
              itemExtent:100,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
              shrinkWrap: true,
              itemCount: controller.users.value.length,
            )),
          ),
        ],
      ),
    );
  }
}
