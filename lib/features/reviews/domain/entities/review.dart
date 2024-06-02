import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String userName;
  final String userImage;
  final int rating;
  final String comment;
  final Timestamp createdAt;

  const Review({
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        userName,
        userImage,
        rating,
        comment,
        createdAt,
      ];
}
