import 'package:dartz/dartz.dart';
import 'package:firebase_shoe_store/core/base/use_case.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/create_review_request.dart';
import 'package:firebase_shoe_store/features/reviews/domain/repositories/review_repository.dart';

class CreateReview
    implements UseCase<Either<String, String>, CreateReviewRequest> {
  final ReviewRepository repository;

  CreateReview({required this.repository});

  @override
  call(CreateReviewRequest request) async {
    return await repository.createReview(request);
  }
}
