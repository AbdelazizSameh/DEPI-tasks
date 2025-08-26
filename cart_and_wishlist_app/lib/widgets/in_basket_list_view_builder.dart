import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/widgets/in_basket_product_card.dart';
import 'package:flutter/material.dart';

class InBasketProductListViewBuilder extends StatelessWidget {
  const InBasketProductListViewBuilder({
    super.key,
    required this.cartItems,
    required this.productProvider,
  });

  final List<ProductModel> cartItems;
  final ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final product = cartItems[index];
        return InBasketProductCard(
          product: product,
          productProvider: productProvider,
        );
      },
    );
  }
}
