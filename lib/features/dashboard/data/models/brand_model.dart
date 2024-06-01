import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/entities/brand_entity.dart';

class BrandModel extends Brand {
  const BrandModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory BrandModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return BrandModel(id: doc.id, name: data['name'], logo: data['logo']);
  }

  Brand toEntity() {
    return Brand(id: super.id, name: super.name, logo: super.logo);
  }
}
