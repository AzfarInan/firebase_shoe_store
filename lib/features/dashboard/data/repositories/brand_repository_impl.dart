import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/dashboard/data/data_sources/brand_data_source.dart';
import 'package:firebase_shoe_store/features/dashboard/data/models/brand_model.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/repositories/brand_repository.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandDataSource dataSource;

  BrandRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Brand>>> getAllBrands(String? lastId) async {
    try {
      List<BrandModel> brands = await dataSource.getBrands(lastId);

      return Right(brands.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Failure('Failed to fetch brands'));
    }
  }
}
