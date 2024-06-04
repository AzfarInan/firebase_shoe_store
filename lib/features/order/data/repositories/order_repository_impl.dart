import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/data/data_sources/order_data_source.dart';
import 'package:firebase_shoe_store/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> createOrder(
      {required List<Cart> carts}) async {
    try {
      var message = await dataSource.createOrder(carts: carts);
      return Right(message);
    } catch (e) {
      return Left(Failure('Failed to create order'));
    }
  }
}
