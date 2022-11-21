import 'package:flutter/cupertino.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 320.0,
      products: [
        CartItem(
          id: 'c1',
          title: 'Nike_Air_Jordan_1_Retro_High_Og',
          price: 160,
          quantity: 2,
        )
      ],
      dateTime: DateTime.now(),
    )
  ];

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }
}
