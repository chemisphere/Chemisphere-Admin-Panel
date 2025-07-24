import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/dashboard/dashboard_controller.dart';

class OrderRows extends DataTableSource{

  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(cells:[
      DataCell(Text(order.id,style:Theme.of(Get.context!).textTheme.bodyLarge!.apply(color:TColors.primary)
      )),
      DataCell(Text(order.formattedOrderDate)),
       DataCell(TRoundedContainer(
        radius:TSizes.cardRadiusSm,
        padding:const EdgeInsets.symmetric(vertical:TSizes.xs4, horizontal:TSizes.md16),
        backgroundColor:THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
           child:Text(
            order.status.name.capitalize.toString(),
            style:TextStyle(color:THelperFunctions.getOrderStatusColor(order.status))
           )
         )
       ),
      DataCell(Text("\$${order.totalAmount}"))
    ]);
  }

  @override
  bool get isRowCountApproximate =>false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;

}