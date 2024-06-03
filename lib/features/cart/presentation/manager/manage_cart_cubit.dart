import 'package:firebase_shoe_store/core/base/base_state.dart';
import 'package:firebase_shoe_store/core/cache_service/cache_manager.dart';
import 'package:firebase_shoe_store/core/service_locator/service_locator.dart';
import 'package:firebase_shoe_store/features/cart/domain/entities/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageCartCubit extends Cubit<BaseState> {
  ManageCartCubit() : super(InitialState());

  List<Cart> cartItems = [];

  void addToCart(Cart cart) {
    emit(const LoadingState());

    /// Check if the item is already in the cart
    final int isItemInCart = cartItems.indexWhere(
      (element) => element.cartItem.productId == cart.cartItem.productId,
    );

    if (isItemInCart != -1) {
      var tempQuantity = cartItems[isItemInCart].quantity + cart.quantity;
      var total = cartItems[isItemInCart].total + cart.total;
      cartItems[isItemInCart] = Cart(
        cartItem: cartItems[isItemInCart].cartItem,
        quantity: tempQuantity,
        color: cart.color,
        size: cart.size,
        total: total,
      );
      _updateCache();
      emit(const SuccessState(data: 'Added to cart'));

      return;
    }

    cartItems.add(cart);
    _updateCache();
    emit(const SuccessState(data: 'Added to cart'));
  }

  void removeFromCart(Cart cart) {
    emit(const LoadingState());
    cartItems.remove(cart);
    _updateCache();
    emit(const SuccessState(data: 'Removed from cart'));
  }

  void _updateCache() {
    getIt.get<CacheManager>().clearCart();
    getIt.get<CacheManager>().saveCart(cartItems);
  }

  void getItemsFromCache() async {
    resetCart();
    cartItems = await getIt.get<CacheManager>().getCarts();
  }

  void resetCart() {
    cartItems.clear();
  }
}
