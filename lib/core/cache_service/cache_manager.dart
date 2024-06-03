import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';

abstract class CacheManager {
  Future<void> saveCart(List<Cart> cartItems);
  Future<List<Cart>> getCarts();
  Future<void> clearCart();
}