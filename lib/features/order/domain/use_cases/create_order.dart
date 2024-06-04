import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/use_case.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/domain/repositories/order_repository.dart';

class CreateOrder implements UseCase<Either<String, String>, List<Cart>> {
  final OrderRepository repository;

  CreateOrder({required this.repository});

  @override
  call(List<Cart> carts) async {
    return await repository.createOrder(carts: carts);
  }
}
