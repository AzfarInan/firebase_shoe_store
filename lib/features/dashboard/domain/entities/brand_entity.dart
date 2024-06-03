import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String id;
  final String name;
  final String logo;
  final List<dynamic> products;

  const Brand({
    required this.id,
    required this.name,
    required this.logo,
    required this.products,
  });

  @override
  List<Object> get props => [id, name, logo, products];
}
