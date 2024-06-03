import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/product_details/data/models/product_request_model.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/product_details/domain/use_cases/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class GetProductsCubit extends Cubit<BaseState> {
  GetProductsCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetProducts useCase;

  final List<Product> products = [];
  String? lastId;
  bool eop = false;

  Future<void> getProducts({
    bool firstTime = false,
    required String brandId,
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
      final result = await useCase.call(
        ProductRequestModel(
          brandId: brandId,
          lastId: lastId,
        ),
      );
      result.fold(
        (l) => emit(ErrorState(data: l.message!)),
        (r) {
          if ((r).length < 10) {
            eop = true;
          }
          products.addAll(r);
          lastId = products.last.productId;
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
    products.clear();
    lastId = null;
    eop = false;
  }
}
