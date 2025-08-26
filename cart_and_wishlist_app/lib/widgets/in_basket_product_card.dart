import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:flutter/material.dart';

class InBasketProductCard extends StatelessWidget {
  const InBasketProductCard({
    super.key,
    required this.product,
    required this.productProvider,
  });

  final ProductModel product;
  final ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          productProvider.addRemoveInBasket(product);
        },
      ),
    );
  }
}
