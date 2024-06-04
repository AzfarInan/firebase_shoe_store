import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';

class OrderHistoryModel extends OrderHistory {
  const OrderHistoryModel({
    required super.id,
    required super.carts,
    required super.createdAt,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'],
      carts: (json['carts'] as List<dynamic>)
          .map((item) => Cart.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carts': carts.map((cart) => (cart).toJson()).toList(),
      'createdAt': createdAt,
    };
  }
}
