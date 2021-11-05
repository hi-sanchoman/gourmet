import 'package:esentai/models/order/order.dart';
import 'package:esentai/models/order/order_item.dart';

class OrderList {
  final List<Order>? items;

  OrderList({
    this.items,
  });

  factory OrderList.fromMap(Map<String, dynamic> map) {
    List<Order> items = [];
    List<dynamic> results = map['results'];

    items = results.map((item) => Order.fromMap(item)).toList();

    return OrderList(
      items: items,
    );
  }
}
