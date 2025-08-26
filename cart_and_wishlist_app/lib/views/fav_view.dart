import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final favItems = productProvider.favProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: favItems.isEmpty
          ? const Center(child: Text("No items in wishlist"))
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favItems.length,
              itemBuilder: (context, index) {
                final product = favItems[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(product.name),
                    subtitle: Text(product.price),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            productProvider.removeFav(product);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart_outlined),
                          onPressed: () {
                            productProvider.addInBasket(product);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
