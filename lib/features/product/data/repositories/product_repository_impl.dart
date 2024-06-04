import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/product/data/data_sources/product_data_source.dart';
import 'package:firebase_shoe_store/features/product/data/models/product_model.dart';
import 'package:firebase_shoe_store/features/product/data/models/product_request_model.dart';
import 'package:firebase_shoe_store/features/product/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/product/domain/repositories/product_repository.dart';
import 'package:logger/logger.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts(
      ProductRequestModel request) async {
    try {
      List<ProductModel> products = await dataSource.getProducts(request);

      return Right(products.map((e) => e.toEntity()).toList());
    } catch (e) {
      Logger().e(e.toString());
      return Left(Failure('Failed to fetch products'));
    }
  }
}
