import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/widgets/fav_product_list_view_builder.dart';
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
          : FavProductListViewBuilder(
              favItems: favItems,
              productProvider: productProvider,
            ),
    );
  }
}
