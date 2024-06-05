import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageReviewCubit extends Cubit<BaseState> {
  ManageReviewCubit() : super(InitialState());

  String? selectedStar;
  final List<String> stars = [
    'All',
    '5 Stars',
    '4 Stars',
    '3 Stars',
    '2 Stars',
    '1 Star'
  ];
  List<Review> reviewList = [];

  void getInitialReviews(List<Review> reviews) {
    emit(const LoadingState());
    reset();
    reviewList.addAll(reviews);
    reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    emit(const SuccessState());
  }

  void selectStar(String star, List<Review> reviews) {
    emit(const LoadingState());
    selectedStar = star;
    _getReviews(reviews);
    emit(const SuccessState());
  }

  void _getReviews(List<Review> reviews) {
    switch (selectedStar) {
      case 'All':
        reviewList.clear();
        reviewList.addAll(reviews);
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '5 Stars':
        reviewList.clear();
        reviewList
            .addAll(reviews.where((review) => review.rating == 5).toList());
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '4 Stars':
        reviewList.clear();
        reviewList
            .addAll(reviews.where((review) => review.rating == 4).toList());
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '3 Stars':
        reviewList.clear();
        reviewList
            .addAll(reviews.where((review) => review.rating == 3).toList());
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '2 Stars':
        reviewList.clear();
        reviewList
            .addAll(reviews.where((review) => review.rating == 2).toList());
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case '1 Star':
        reviewList.clear();
        reviewList
            .addAll(reviews.where((review) => review.rating == 1).toList());
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      default:
        reviewList.clear();
        reviewList.addAll(reviews);
        reviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
  }

  void reset() {
    selectedStar = 'All';
    reviewList.clear();
  }
}
