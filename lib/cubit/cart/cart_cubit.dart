import 'package:berry_happy/dto/menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  // No events needed
  // CartCubit() : super(const CartInitial());
  CartCubit() : super(const SelectedItems([]));

  void addToCart(Menu item) {
    debugPrint(" id menu = $item.idMenu");
    final currentState = state;
    final existingItem = currentState is SelectedItems
        ? currentState.selectedItems
            .firstWhere((selectedItem) => selectedItem.idMenu == item.idMenu)
        : null;

    if (existingItem != null) {
      // Update quantity if item already exists (not applicable here)
    } else {
      final updatedSelectedItems =
          (currentState as SelectedItems).selectedItems + [item];
      emit(SelectedItems(updatedSelectedItems));
    }
  }

  void removeFromCart(Menu item) {
    final currentState = state;
    if (currentState is SelectedItems) {
      final updatedSelectedItems = (currentState as SelectedItems)
          .selectedItems
          .where((selectedItem) => selectedItem.idMenu != item.idMenu)
          .toList();
      emit(SelectedItems(updatedSelectedItems));
    }
  }
}
