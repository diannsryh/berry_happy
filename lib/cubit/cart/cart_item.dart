// cart_item.dart

import 'package:berry_happy/dto/menu.dart';

class CartItem {
  final Menu menu;
  final int quantity;

  CartItem(this.menu, {this.quantity = 1});
}
