import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/domain/entity/failure.dart';
import 'package:firebase_shoe_store/features/product_details/data/models/product_request_model.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(
      ProductRequestModel request);
}
