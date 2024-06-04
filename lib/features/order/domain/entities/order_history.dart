import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';

class OrderHistory extends Equatable {
  final String id;
  final List<Cart> carts;
  final Timestamp createdAt;

  const OrderHistory({
    required this.id,
    required this.carts,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, carts, createdAt];
}
