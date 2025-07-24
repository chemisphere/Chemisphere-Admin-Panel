import 'package:intl/intl.dart';

import '../../../utils/constants/enums.dart'; // Add this import for date formatting

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });

  // Getter to format the order date
  String get formattedOrderDate {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(orderDate);
  }

// You can also add methods for serialization or other utility methods if needed
}
