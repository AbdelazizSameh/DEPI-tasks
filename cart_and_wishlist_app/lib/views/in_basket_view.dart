import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InBasketView extends StatelessWidget {
  const InBasketView({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartItems = productProvider.inBasketProducts;
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.tryParse(item.price.replaceAll("\$", "")) ?? 0;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return ListTile(
                        title: Text(product.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            productProvider.removeInBasket(product);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Total: \$${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Checkout"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
