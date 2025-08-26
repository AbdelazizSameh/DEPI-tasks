import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/widgets/fav_product_card.dart';
import 'package:flutter/material.dart';

class FavProductListViewBuilder extends StatelessWidget {
  const FavProductListViewBuilder({
    super.key,
    required this.favItems,
    required this.productProvider,
  });

  final List<ProductModel> favItems;
  final ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: favItems.length,
      itemBuilder: (context, index) {
        final product = favItems[index];
        return FavProductCard(
          product: product,
          productProvider: productProvider,
        );
      },
    );
  }
}
