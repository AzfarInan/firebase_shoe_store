import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/use_case.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';
import 'package:firebase_shoe_store/features/order/domain/repositories/order_repository.dart';

class GetOrderHistory
    implements UseCase<Either<String, List<OrderHistory>>, String?> {
  final OrderRepository repository;

  GetOrderHistory({required this.repository});

  @override
  call(String? lastId) async {
    return await repository.getOrderHistory(lastId);
  }
}
