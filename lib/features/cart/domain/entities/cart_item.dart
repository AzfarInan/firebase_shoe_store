import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String? productId;
  final String? name;
  final String? brandId;
  final String? brandLogo;
  final List<dynamic>? images;
  final double? price;
  final String? gender;

  const CartItem({
    required this.productId,
    required this.name,
    required this.brandId,
    required this.brandLogo,
    required this.images,
    required this.price,
    required this.gender,
  });

  String getFirstImage() {
    return images![0];
  }

  /// FromJson
  CartItem.fromJson(Map<String, dynamic> json)
      : productId = json['productId'],
        name = json['name'],
        brandId = json['brandId'],
        brandLogo = json['brandLogo'],
        images = json['images'],
        price = json['price'],
        gender = json['gender'];

  /// ToJson
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'brandId': brandId,
        'brandLogo': brandLogo,
        'images': images,
        'price': price,
        'gender': gender,
      };

  @override
  List<Object?> get props => [
        productId,
        name,
        brandId,
        brandLogo,
        images,
        price,
        gender,
      ];
}
