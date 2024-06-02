import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/review.dart';
import 'package:flutter/material.dart';

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

  Color getColor(int index) {
    if (colors != null && colors!.isNotEmpty) {
      switch (colors![index].toString().toLowerCase()) {
        case 'white':
          return Colors.white;
        case 'black':
          return Colors.black;
        case 'blue':
          return Colors.blue.shade800;
        case 'red':
          return Colors.red.shade800;
        case 'green':
          return Colors.green.shade800;
        case 'yellow':
          return Colors.yellow.shade800;
        case 'purple':
          return Colors.purple.shade800;
        default:
          return Colors.white;
      }
    } else {
      return Colors.white;
    }
  }

  Color getIconColor(int index) {
    if (colors != null && colors!.isNotEmpty) {
      switch (colors![index].toString().toLowerCase()) {
        case 'white':
          return Colors.black;
        default:
          return Colors.white;
      }
    } else {
      return Colors.white;
    }
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
