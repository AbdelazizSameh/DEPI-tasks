import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_state.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/product_card_trailing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final isFav = state.favProducts.contains(product);
          final inCart = state.inBasketProducts.contains(product);

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
