import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder({required List<Cart> carts});
}
