import 'package:cloud_firestore/cloud_firestore.dart';

class CreateReviewRequest {
  final String productId;
  final String userName;
  final String userImage;
  final int rating;
  final String comment;
  final Timestamp createdAt;

  const CreateReviewRequest({
    required this.productId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}
