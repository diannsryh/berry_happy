import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:berry_happy/cubit/cart/cart_cubit.dart';
import 'package:berry_happy/cubit/cart/cart_item.dart' as CartItem;

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 204, 229),
        title: Text(
          'CART',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: BlocBuilder<CartCubit, List<CartItem.CartItem>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(
              child: Text('Cart is empty.'),
            );
          } else {
            // Calculate total amount for all items in the cart
            int totalAmount = 0;
            for (var cartItem in state) {
              totalAmount += cartItem.menu.menuPrice * cartItem.quantity;
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final cartItem = state[index];
                      // Calculate total price for the item
                      final totalPrice =
                          cartItem.menu.menuPrice * cartItem.quantity;
                      return Container(
                        color: Colors.white, // Background color of ListTile
                        child: ListTile(
                          title: Text(cartItem.menu.menuName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: Rp. ${cartItem.menu.menuPrice}'),
                              Text('Quantity: ${cartItem.quantity}'),
                              Text(
                                'Total: Rp. $totalPrice', // Display total price
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              cartCubit.removeFromCart(cartItem);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp. $totalAmount',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add some space between total amount and button
                GestureDetector(
                  onTap: () {
                    cartCubit
                        .removeAllItems(); // Call removeAllItems method in CartCubit
                    // Show a snackbar when items are deleted
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Checked out'),
                        duration: Duration(
                            seconds: 2), // Adjust the duration as needed
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity, // Full width container
                    padding: EdgeInsets.all(16),
                    color: Colors.pink,
                    child: Text(
                      'Check Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
