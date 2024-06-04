import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder({required List<Cart> carts});
  Future<Either<Failure, List<OrderHistory>>> getOrderHistory(String? lastId);
}
