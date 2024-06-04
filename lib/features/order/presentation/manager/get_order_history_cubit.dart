import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/order/domain/entities/order_history.dart';
import 'package:firebase_shoe_store/features/order/domain/use_cases/get_order_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class GetOrderHistoryCubit extends Cubit<BaseState> {
  GetOrderHistoryCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetOrderHistory useCase;

  final List<OrderHistory> list = [];
  String? lastId;
  bool eop = false;

  Future<void> getOrderHistory({
    bool firstTime = false,
  }) async {
    if (firstTime) {
      clearData();
    }
    if (eop) {
      return;
    }

    lastId == null
        ? emit(const LoadingState())
        : emit(const LoadingAgainState());
    try {
      final result = await useCase.call(lastId);
      result.fold(
        (l) => emit(ErrorState(data: l.message!)),
        (r) {
          if ((r).length < 10) {
            eop = true;
          }
          lastId = (r).last.id;
          list.addAll(r);
          return emit(SuccessState(data: r));
        },
      );
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  void clearData() {
    list.clear();
    lastId = null;
    eop = false;
  }
}
