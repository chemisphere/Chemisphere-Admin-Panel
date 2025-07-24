import 'package:education_web_admin_panel/features/authentication/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/enums.dart';

class BatchesDropdown extends StatelessWidget {
  const BatchesDropdown({super.key, this.onChanged});

  final void Function(Batch?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(UserController());
    return Obx((){
      return SizedBox(
        width:125,child: DropdownButtonFormField(
        isExpanded: false,
        value: controller.batchPath.value,
        items: Batch.values
            .map((batches) =>
            DropdownMenuItem(
              value: batches,
              child: Text(batches.name.capitalize.toString()),
            )).toList(),
        onChanged:onChanged,
        )
      );
    });
  }
}
