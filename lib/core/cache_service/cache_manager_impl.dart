import 'dart:convert';

import 'package:firebase_shoe_store/core/cache_service/cache_keys.dart';
import 'package:firebase_shoe_store/core/cache_service/cache_manager.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManagerImpl extends CacheManager {
  final SharedPreferences _sharedPreferences;

  CacheManagerImpl(this._sharedPreferences);

  @override
  Future<void> saveCart(List<Cart> cartItems) async {
    final String cartsJson =
        jsonEncode(cartItems.map((cart) => cart.toJson()).toList());
    await _sharedPreferences.setString(CacheKeys.carts, cartsJson);
  }

  @override
  Future<List<Cart>> getCarts() async {
    final String? cartsJson = _sharedPreferences.getString(CacheKeys.carts);
    if (cartsJson != null) {
      final List<dynamic> cartsList = jsonDecode(cartsJson);
      return cartsList.map((cart) => Cart.fromJson(cart)).toList();
    }
    return [];
  }

  @override
  Future<void> clearCart() async {
    await _sharedPreferences.remove(CacheKeys.carts);
  }
}
