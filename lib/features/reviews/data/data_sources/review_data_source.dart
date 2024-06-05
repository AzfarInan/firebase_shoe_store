import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/core/firebase_functions/firebase_functions.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/create_review_request.dart';

abstract class ReviewDataSource {
  Future<String> createReview(CreateReviewRequest request);
}

class ReviewDataSourceImpl implements ReviewDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> createReview(CreateReviewRequest request) async {
    try {
      final reviewData = {
        'userName': request.userName,
        'userImage': request.userImage,
        'rating': request.rating,
        'comment': request.comment,
        'createdAt': request.createdAt,
      };

      await _firestore.collection('products').doc(request.productId).update({
        'reviews': FieldValue.arrayUnion([reviewData])
      });

      await updateProductRating(request.productId);
      return 'Review added successfully';
    } catch (e) {
      throw Exception('Error adding review: $e');
    }
  }
}
