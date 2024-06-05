import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/core/widgets/number_formats.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart_item.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  String brandColorQuantity(BuildContext context) {
    return '${BlocProvider.of<GetBrandsCubit>(context).getBrandName(cartItem.brandId!)} . $color . $size . Qty $quantity';
  }

  String brandColorSize(BuildContext context) {
    return '${BlocProvider.of<GetBrandsCubit>(context).getBrandName(cartItem.brandId!)} . $color . $size';
  }

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
