import 'package:firebase_shoe_store/core/base/domain/use_case/use_case.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/repositories/brand_repository.dart';

class GetBrands implements UseCase<(String, void), String?> {
  final BrandRepository repository;

  GetBrands({required this.repository});

  @override
  call(String? lastId) async {
    return await repository.getAllBrands(lastId);
  }
}
