import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/core/widgets/number_formats.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:flutter/cupertino.dart';

class OrderHistory extends Equatable {
  final String id;
  final List<Cart> carts;
  final Timestamp createdAt;

  const OrderHistory({
    required this.id,
    required this.carts,
    required this.createdAt,
  });

  String getTotal() {
    double total = 0;
    for (var cart in carts) {
      total += cart.total;
    }
    return formatCurrency(total);
  }

  String getFirstImage() {
    return carts.first.cartItem.images!.first;
  }

  String getFirstTitle() {
    return carts.first.cartItem.name!;
  }

  String getFirstTotal() {
    return formatCurrency(carts.first.total);
  }

  String getFirstQuantity() {
    return "Qty: ${carts.first.quantity.toString()}";
  }

  String getFirstLogo() {
    return carts.first.cartItem.brandLogo!;
  }

  String getFirstBrandColorSize(BuildContext context) {
    return carts.first.brandColorSize(context);
  }

  /// Get Date as 24th June, 2024
  String getFormattedDate() {
    return formatTimestamp(createdAt);
  }

  @override
  List<Object?> get props => [id, carts, createdAt];
}
