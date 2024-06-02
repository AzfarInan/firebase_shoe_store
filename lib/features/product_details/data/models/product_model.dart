import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/features/product_details/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
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
      ratings: data['ratings'] ?? 0.0,
      reviews: data['reviews'] ?? [],
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
