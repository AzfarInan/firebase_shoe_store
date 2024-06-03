import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_shoe_store/features/product_details/data/models/product_model.dart';
import 'package:firebase_shoe_store/features/product_details/data/models/product_request_model.dart';
import 'package:logger/logger.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts(ProductRequestModel request);
}

class ProductDataSourceImpl implements ProductDataSource {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Future<List<ProductModel>> getProducts(ProductRequestModel request) async {
    try {
      Query query = _productsCollection.limit(10);

      /// Filter by brandId if not 'All'
      if (request.brandId != 'All') {
        query = query.where('brandId', isEqualTo: request.brandId);
      }

      /// Handle pagination if lastId is provided
      if (request.lastId != null && request.lastId!.isNotEmpty) {
        DocumentSnapshot lastDoc =
            await _productsCollection.doc(request.lastId).get();
        if (!lastDoc.exists) {
          throw Exception(
              "The lastId document does not exist in the collection.");
        }
        query = query.startAfterDocument(lastDoc);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<ProductModel> products = querySnapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();

      /// Update product rating if it is 0
      products.forEach((product) async {
        if (product.ratings! <= 0.0) {
          Logger().i('Updating product rating for ${product.name}');
          await updateProductRating(product.productId!);
        }
      });

      Logger().i('Products fetched successfully: ${products.length} products');
      return products;
    } catch (e) {
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<void> updateProductRating(String productId) async {
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('calculateAverageProductRatings');
      final result = await callable.call(<String, dynamic>{
        'productId': productId,
      });
      print(result.data['message']);
    } catch (e) {
      print('Failed to update product rating: $e');
    }
  }
}
