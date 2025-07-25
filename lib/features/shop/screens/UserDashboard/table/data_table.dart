import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../utils/constants/sizes.dart';
import 'table_source.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
      minWidth:700,
        tableHeight:400,
        dataRowHeight:TSizes.xl32*1.2,
        columns:const [
          DataColumn2(label:Text("Order ID")),
          DataColumn2(label:Text("Date")),
          DataColumn2(label:Text("Items")),
          DataColumn2(label:Text("Amount")),
        ],
        source:OrderRows());
  }
}
