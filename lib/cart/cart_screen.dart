import 'package:berry_happy/cubit/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 204, 229),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'CART',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              //logika hapus data chart
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: context.read<CartCubit>(),
        builder: (context, state) {
          if (state is SelectedItems) {
            final selectedItems = state.selectedItems;
            return ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return ListTile(
                  title: Text(item.menuName),
                  subtitle: Text('${item.menuPrice}'),
                  // ... add other item details as needed
                );
              },
            );
          } else {
            return const Text('Unexpected state'); // Handle unexpected states
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 229),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); //arahkan ke halaman checkout
              },
              child: Text(
                'Go to Checkout',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
