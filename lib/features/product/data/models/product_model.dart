import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/features/product/domain/entities/product.dart';
import 'package:firebase_shoe_store/features/reviews/domain/entities/review.dart';

class ProductModel extends Product {
  ProductModel({
    required super.productId,
    required super.name,
    required super.brandId,
    required super.brandLogo,
    required super.images,
    required super.colors,
    required super.sizes,
    required super.description,
    required super.price,
    required super.gender,
    required super.ratings,
    required super.reviews,
    required super.createdAt,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      name: data['name'],
      brandId: data['brandId'],
      brandLogo: data['brandLogo'],
      images: data['images'],
      colors: data['colors'],
      sizes: data['sizes'],
      description: data['description'],
      price: data['price'],
      productId: doc.id,
      gender: data['gender'],
      ratings: data['ratings'] != null
          ? double.parse(data['ratings'].toStringAsFixed(2))
          : 0.00,
      reviews: data['reviews'] != null
          ? List.from(data['reviews'])
              .map(
                (e) => Review(
                  userName: e['userName'],
                  userImage: e['userImage'],
                  rating: e['rating'],
                  comment: e['comment'],
                  createdAt: e['createdAt'],
                ),
              )
              .toList()
          : [],
      createdAt: data['createdAt'],
    );
  }

  Product toEntity() {
    return Product(
      name: super.name,
      productId: super.productId,
      brandId: super.brandId,
      brandLogo: super.brandLogo,
      images: super.images,
      colors: super.colors,
      sizes: super.sizes,
      description: super.description,
      price: super.price,
      gender: super.gender,
      ratings: super.ratings,
      reviews: super.reviews,
      createdAt: super.createdAt,
    );
  }
}
