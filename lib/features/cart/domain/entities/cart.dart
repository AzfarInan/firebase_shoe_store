import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart_item.dart';

class Cart extends Equatable {
  final CartItem cartItem;
  final int quantity;
  final String color;
  final double size;
  final double total;

  const Cart({
    required this.cartItem,
    required this.quantity,
    required this.color,
    required this.size,
    required this.total,
  });

  /// FromJson
  Cart.fromJson(Map<String, dynamic> json)
      : cartItem = CartItem.fromJson(json['cartItem']),
        quantity = json['quantity'],
        color = json['color'],
        size = json['size'],
        total = json['total'];

  /// ToJson
  Map<String, dynamic> toJson() => {
        'cartItem': cartItem.toJson(),
        'quantity': quantity,
        'color': color,
        'size': size,
        'total': total,
      };

  @override
  List<Object> get props => [cartItem, quantity, color, size, total];
}
