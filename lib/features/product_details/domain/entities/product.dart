import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/review.dart';

class Product extends Equatable {
  final String? productId;
  final String? name;
  final String? brandId;
  final String? brandLogo;
  final List<dynamic>? images;
  final List<dynamic>? colors;
  final List<dynamic>? sizes;
  final String? description;
  final double? price;
  final String? gender;
  final double? ratings;
  final List<Review>? reviews;
  final Timestamp? createdAt;

  const Product({
    required this.productId,
    required this.name,
    required this.brandId,
    required this.brandLogo,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.description,
    required this.price,
    required this.gender,
    required this.ratings,
    required this.reviews,
    required this.createdAt,
  });

  String getFirstImage() {
    return images != null && images!.isNotEmpty ? images!.first : '';
  }

  @override
  List<Object?> get props => [
        productId,
        name,
        brandId,
        brandLogo,
        images,
        colors,
        sizes,
        description,
        price,
        gender,
        ratings,
        reviews,
        createdAt,
      ];
}
