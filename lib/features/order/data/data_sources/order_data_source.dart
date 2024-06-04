import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:firebase_shoe_store/features/order/data/models/order_history_model.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

abstract class OrderDataSource {
  Future<String> createOrder({required List<Cart> carts});
  Future<List<OrderHistoryModel>> getOrderHistory(String? lastId);
}

class OrderDataSourceImpl implements OrderDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  @override
  Future<String> createOrder({required List<Cart> carts}) async {
    try {
      /// Convert each Cart to a JSON-compatible Map
      List<Map<String, dynamic>> cartsData =
          carts.map((cart) => cart.toJson()).toList();

      /// Generate a new document ID
      String orderId = _uuid.v4();

      // Create a new document in the 'orders' collection with the generated ID
      await _firestore.collection('orders').doc(orderId).set({
        'carts': cartsData,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Logger().i('Order created with ID: $orderId');
      return 'Order created successfully';
    } catch (e) {
      Logger().e('Error creating order: $e');
      return 'Error creating order';
    }
  }

  @override
  Future<List<OrderHistoryModel>> getOrderHistory(String? lastId) async {
    try {
      Query query = _firestore
          .collection('orders')
          .orderBy(
        'createdAt',
        descending: true,
      )
          .limit(10);

      if (lastId != null) {
        DocumentSnapshot lastDoc =
        await _firestore.collection('orders').doc(lastId).get();
        query = query.startAfterDocument(lastDoc);
      }

      QuerySnapshot querySnapshot = await query.get();

      Logger()
          .i(
          'Order History fetched successfully: ${querySnapshot.docs.length}');
      return querySnapshot.docs.map((doc) {
        return OrderHistoryModel.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    } catch (e) {
      Logger().e('Error fetching order history: $e');
      return [];
    }
  }
}
