import 'package:cloud_functions/cloud_functions.dart';

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
