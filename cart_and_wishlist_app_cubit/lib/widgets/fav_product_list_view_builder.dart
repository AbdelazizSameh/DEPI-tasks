import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/fav_product_card.dart';
import 'package:flutter/material.dart';

class FavProductListViewBuilder extends StatelessWidget {
  const FavProductListViewBuilder({
    super.key,
    required this.favItems,
    required this.productCubit,
  });

  final List<ProductModel> favItems;
  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: favItems.length,
      itemBuilder: (context, index) {
        final product = favItems[index];
        return FavProductCard(product: product, productCubit: productCubit);
      },
    );
  }
}
