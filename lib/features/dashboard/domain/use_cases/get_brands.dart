import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/use_case.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/repositories/brand_repository.dart';

class GetBrands implements UseCase<Either<String, List<Brand>>, String?> {
  final BrandRepository repository;

  GetBrands({required this.repository});

  @override
  call(String? lastId) async {
    return await repository.getAllBrands(lastId);
  }
}
