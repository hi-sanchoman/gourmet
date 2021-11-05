import 'package:esentai/models/order/order_item.dart';

class OrderItemList {
  final List<OrderItem>? items;

  OrderItemList({
    this.items,
  });

  factory OrderItemList.fromMap(List<dynamic> map) {
    // print("order item list...");
    // print(map.toString());

    List<OrderItem> items = <OrderItem>[];
    items = map.map((item) => OrderItem.fromMap(item)).toList();

    return OrderItemList(
      items: items,
    );
  }
}
