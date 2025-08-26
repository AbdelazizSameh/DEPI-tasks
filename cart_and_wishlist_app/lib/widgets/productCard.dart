import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/widgets/product_card_trailing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          final isFav = provider.favProducts.contains(product);
          final inCart = provider.inBasketProducts.contains(product);

          return ListTile(
            leading: const Icon(Icons.shopping_bag, size: 40),
            title: Text(product.name),
            subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            trailing: ProductCardTrailing(
              isFav: isFav,
              product: product,
              inCart: inCart,
            ),
          );
        },
      ),
    );
  }
}
