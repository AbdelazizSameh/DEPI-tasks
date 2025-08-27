import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:flutter/material.dart';

class InBasketProductCard extends StatelessWidget {
  const InBasketProductCard({
    super.key,
    required this.product,
    required this.productCubit,
  });

  final ProductModel product;
  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      trailing: IconButton(
        icon: const Icon(Icons.remove),
        onPressed: () {
          productCubit.removeItemfromBasket(product);
        },
      ),
    );
  }
}
