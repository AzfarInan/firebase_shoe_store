import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/data/data_sources/order_data_source.dart';
import 'package:firebase_shoe_store/features/order/data/models/order_history_model.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';
import 'package:firebase_shoe_store/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> createOrder({
    required List<Cart> carts,
  }) async {
    try {
      var message = await dataSource.createOrder(carts: carts);
      return Right(message);
    } catch (e) {
      return Left(Failure('Failed to create order'));
    }
  }

  @override
  Future<Either<Failure, List<OrderHistory>>> getOrderHistory(
      String? lastId) async {
    try {
      List<OrderHistoryModel> orders = await dataSource.getOrderHistory(lastId);

      return Right(orders);
    } catch (e) {
      return Left(Failure('Failed to fetch order history'));
    }
  }
}
