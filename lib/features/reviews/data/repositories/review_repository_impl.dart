import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/reviews/data/data_sources/review_data_source.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/create_review_request.dart';
import 'package:firebase_shoe_store/features/reviews/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource dataSource;

  ReviewRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> createReview(
      CreateReviewRequest request) async {
    try {
      var message = await dataSource.createReview(request);
      return Right(message);
    } catch (e) {
      return Left(Failure('Failed to create review'));
    }
  }
}
