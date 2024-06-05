import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/failure.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/create_review_request.dart';

abstract class ReviewRepository {
  Future<Either<Failure, String>> createReview(CreateReviewRequest request);
}
