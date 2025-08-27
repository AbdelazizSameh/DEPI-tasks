import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/in_basket_product_card.dart';
import 'package:flutter/material.dart';

class InBasketProductListViewBuilder extends StatelessWidget {
  const InBasketProductListViewBuilder({
    super.key,
    required this.cartItems,
    required this.productCubit,
  });

  final List<ProductModel> cartItems;
  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final product = cartItems[index];
        return InBasketProductCard(
          product: product,
          productCubit: productCubit,
        );
      },
    );
  }
}
