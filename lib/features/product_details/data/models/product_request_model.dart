class ProductRequestModel {
  final String brandId;
  final String? lastId;
  final String? gender;
  final String? color;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy; /// 'recent', 'lowest price', 'highest price'

  ProductRequestModel({
    required this.brandId,
    this.lastId,
    this.gender,
    this.color,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
  });
}
