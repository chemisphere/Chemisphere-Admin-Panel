import 'package:get/get.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/order_model.dart';

class DashboardController extends GetxController{
  static DashboardController get instance => Get.find();


  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  /// ODER
  static final List<OrderModel> orders = [
    OrderModel(
      id:"CWT101",
      status:OrderStatus.pending,
        totalAmount: 210,
      orderDate:DateTime(2024,5,21),
      deliveryDate:DateTime(2024,1,23)),
    OrderModel(
        id:"CWT102",
        status:OrderStatus.cancelled,
        totalAmount: 360,
        orderDate:DateTime(2021,5,21),
        deliveryDate:DateTime(2025,5,23)),
    OrderModel(
        id:"CWT103",
        status:OrderStatus.delivered,
        totalAmount: 510,
        orderDate:DateTime(2024,5,21),
        deliveryDate:DateTime(2024,5,23)),
    OrderModel(
        id:"CWT104",
        status:OrderStatus.shipped,
        totalAmount: 100,
        orderDate:DateTime(2021,4,21),
        deliveryDate:DateTime(2022,1,23)),
    OrderModel(
        id:"CWT105",
        status:OrderStatus.processing,
        totalAmount: 200,
        orderDate:DateTime(2024,9,21),
        deliveryDate:DateTime(2024,3,23)),
    OrderModel(
        id:"CWT105",
        status:OrderStatus.processing,
        totalAmount: 200,
        orderDate:DateTime(2024,9,21),
        deliveryDate:DateTime(2024,3,23)),
    OrderModel(
        id:"CWT105",
        status:OrderStatus.processing,
        totalAmount: 200,
        orderDate:DateTime(2024,9,21),
        deliveryDate:DateTime(2024,3,23)),
    OrderModel(
        id:"CWT105",
        status:OrderStatus.processing,
        totalAmount: 200,
        orderDate:DateTime(2024,9,21),
        deliveryDate:DateTime(2024,3,23)),
    OrderModel(
        id:"CWT105",
        status:OrderStatus.processing,
        totalAmount: 200,
        orderDate:DateTime(2024,9,21),
        deliveryDate:DateTime(2024,3,23)),
  ];

  @override
  void onInit(){
    _calculateOrderStatusData();
    _calculatedWeeklySales();
    super.onInit();
  }


  /// CALCULATE ORDER STATUS DATA
  void _calculateOrderStatusData(){
    /// RESET STATUS DATA
    orderStatusData.clear();

    /// MAP TO STORE TOTAL AMOUNTS FOR EACH STATUS
    totalAmounts.value = {
      for(var status in OrderStatus.values) status : 0.0
    };

    for(var order in orders){
      /// COUNTS ORDERS
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      /// CALCULATE TOTAL AMOUNT FOR EACH STATUS
      totalAmounts[status] = (totalAmounts[status] ??0) + order.totalAmount;
    }
  }


  ///  DISPLAY STATUS NAME
  String getDisplayStatusName(OrderStatus status){
    switch(status){
      case OrderStatus.pending:
        return "Pending";

      case OrderStatus.processing:
        return "Processing";

      case OrderStatus.shipped:
        return "Shipped";

      case OrderStatus.delivered:
        return "Delivered";

      case OrderStatus.cancelled:
        return "Cancelled";

        default:
          return "Unknown";
    }
  }

  /// CALCULATE WEEKLY SALES
  void _calculatedWeeklySales(){
    /// RESET WEEKLY SALES TO ZEROS
    weeklySales.value = List<double>.filled(7,0.0);

    for(var order in orders){
      final DateTime orderWeekStart = THelperFunctions.getStartOfWeek(order.orderDate);

      /// CHECK IF THE ORDER IS WITHIN THE CURRENT WEEK
      if(orderWeekStart.isBefore(DateTime.now()) && orderWeekStart.add(const Duration(days:7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;


        ///ENSURE THE INDEX IS NON-NEGATIVE
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;

        print('OrderDate: ${order.orderDate},CurrentWeekDay: $orderWeekStart');
      }
    }
    print('Weekly Sales: $weeklySales');
  }
}