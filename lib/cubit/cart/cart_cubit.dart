// cart_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:berry_happy/cubit/cart/cart_item.dart'
    as CartItem; // Import CartItem from cart_item.dart with prefix
import 'package:berry_happy/dto/menu.dart';

class CartCubit extends Cubit<List<CartItem.CartItem>> {
  // Use CartItem.CartItem with prefix
  CartCubit() : super([]);

  void addToCart(Menu menu) {
    bool alreadyInCart = false;
    state.forEach((item) {
      if (item.menu == menu) {
        emit(state
            .map((e) => e.menu == menu
                ? CartItem.CartItem(menu, quantity: e.quantity + 1)
                : e)
            .toList());
        alreadyInCart = true;
      }
    });
    if (!alreadyInCart) {
      emit([...state, CartItem.CartItem(menu)]);
    }

    print('Cart state after addToCart: $state');
  }

  void removeFromCart(CartItem.CartItem item) {
    emit(state.where((element) => element != item).toList());
    print('Cart state after removeFromCart: $state');
  }

  void removeAllItems() {
    emit([]); // Clear all items from the cart
    print('Cart state after removeAllItems: $state');
  }

  void clearCart() {}
}
