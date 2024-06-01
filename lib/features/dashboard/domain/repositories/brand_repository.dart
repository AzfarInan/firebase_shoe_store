import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/domain/entity/failure.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';

abstract class BrandRepository {
  Future<Either<Failure, List<Brand>>> getAllBrands(String? lastId);
}
