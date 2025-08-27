import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:flutter/material.dart';

class FavProductCard extends StatelessWidget {
  const FavProductCard({
    super.key,
    required this.product,
    required this.productCubit,
  });

  final ProductModel product;
  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.favorite, color: Colors.red),
        title: Text(product.name),
        subtitle: Text(product.price.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                productCubit.removeItemfromFav(product);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              onPressed: () {
                productCubit.toggleBasket(product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
