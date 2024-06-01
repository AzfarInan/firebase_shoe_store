import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/features/dashboard/data/models/brand_model.dart';
import 'package:logger/logger.dart';

abstract class BrandDataSource {
  Future<List<BrandModel>> getBrands(String? startAfter);
}

class BrandDataSourceImpl implements BrandDataSource {
  final CollectionReference _brandsCollection =
      FirebaseFirestore.instance.collection('brands');

  @override
  Future<List<BrandModel>> getBrands(String? startAfter) async {
    Query query = _brandsCollection.orderBy('name').limit(10);

    if (startAfter != null) {
      DocumentSnapshot lastDoc = await _brandsCollection.doc(startAfter).get();
      query = query.startAfterDocument(lastDoc);
    }

    QuerySnapshot querySnapshot = await query.get();

    Logger().i('Brands fetched successfully: ${querySnapshot.docs.length}');
    return querySnapshot.docs
        .map((doc) => BrandModel.fromFirestore(doc))
        .toList();
  }
}
