import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/use_cases/get_brands.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class GetBrandsCubit extends Cubit<BaseState> {
  GetBrandsCubit({
    required this.useCase,
  }) : super(InitialState());

  final GetBrands useCase;

  final List<Brand> brands = [
    const Brand(id: 'All', name: 'All', logo: '', products: [])
  ];
  Brand? selectedBrand;
  String? lastId;
  bool eop = false;

  Future<void> getBrands({
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
        (l) => emit(ErrorState(data: l.error!.message!)),
        (r) {
          if ((r).length < 10) {
            eop = true;
          }
          lastId = (r).last.id;
          brands.addAll(r);
          return emit(SuccessState(data: r));
        },
      );
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }

  void selectBrand(String brandId) {
    emit(const LoadingAgainState());
    final brand = brands.firstWhere((element) => element.id == brandId);
    selectedBrand = brand;
    emit(const SuccessState());
  }

  String getBrandName(String brandId) {
    final brand = brands.firstWhere((element) => element.id == brandId);
    return brand.name;
  }

  void clearData() {
    brands.clear();
    brands.add(const Brand(id: 'All', name: 'All', logo: '', products: []));
    lastId = null;
    selectedBrand = null;
    selectedBrand = brands.first;
    eop = false;
  }
}
