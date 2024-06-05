import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/create_review_request.dart';
import 'package:firebase_shoe_store/features/reviews/domain/use_cases/create_review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class CreateReviewCubit extends Cubit<BaseState> {
  CreateReviewCubit({
    required this.useCase,
  }) : super(InitialState());

  final CreateReview useCase;

  Future<void> createReview({required CreateReviewRequest request}) async {
    emit(const LoadingState());

    try {
      final result = await useCase.call(request);
      result.fold(
        (l) => emit(ErrorState(data: l.message!)),
        (r) => emit(SuccessState(data: r)),
      );
    } catch (e, stackTrace) {
      Logger().e(e.toString());
      Logger().e(stackTrace.toString());
      emit(const ErrorState(data: 'Something went wrong'));
    }
  }
}
