import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/domain/use_cases/create_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class CreateOrderCubit extends Cubit<BaseState> {
  CreateOrderCubit({
    required this.useCase,
  }) : super(InitialState());

  final CreateOrder useCase;

  Future<void> createOrder({required List<Cart> carts}) async {
    emit(const LoadingState());

    try {
      final result = await useCase.call(carts);
      result.fold(
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
