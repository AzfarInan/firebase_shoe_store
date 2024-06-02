import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/domain/use_case/use_case.dart';
import 'package:firebase_shoe_store/features/product_details/data/models/product_request_model.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/product_details/domain/repositories/product_repository.dart';


class GetProducts
    implements UseCase<Either<String, List<Product>>, ProductRequestModel> {
  final ProductRepository repository;

  GetProducts({required this.repository});

  @override
  call(ProductRequestModel request) async {
    return await repository.getProducts(request);
  }
}
