import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_pal/models%20&%20providers/cart.dart';
import 'package:pill_pal/models%20&%20providers/product.dart';
import 'package:pill_pal/services/global_methods.dart';


import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../home_screen.dart';
import 'empty_cart.dart';
import 'full_cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/Cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return cartProvider.cartList.isEmpty
        ? const Scaffold(
            body: EmptyCart(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart (${cartProvider.cartList.length})'),
              actions: [
                IconButton(
                  onPressed: () async {
                    await globalMethods.showDialogue(
                      context,
                      () => cartProvider.clearCart(),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            body: Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cartProvider.cartList.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider.value(
                    value: cartProvider.cartList.values.toList()[i],
                    child: FullCart(
                      pId: cartProvider.cartList.keys.toList()[i],
                      // id: cartProvider.cartList.values.toList()[i].cartId,
                      // imageUrl: cartProvider.cartList.values.toList()[i].imageUrl,
                      // price: cartProvider.cartList.values.toList()[i].price,
                      // quantity: cartProvider.cartList.values.toList()[i].quantity,
                      // title: cartProvider.cartList.values.toList()[i].title,
                    ),
                  );
                },
              ),
            ),
            bottomSheet: _bottomCheckoutSectiomn(cartProvider.totalAmount),
          );
  }
}

Widget _bottomCheckoutSectiomn(double totalAmount) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Total: \Rs ${(totalAmount+300).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              '   C H E C K O U T   ',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
