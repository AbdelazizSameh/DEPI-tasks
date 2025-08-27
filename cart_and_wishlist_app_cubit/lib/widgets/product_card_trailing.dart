import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardTrailing extends StatelessWidget {
  const ProductCardTrailing({
    super.key,
    required this.isFav,
    required this.product,
    required this.inCart,
  });

  final bool isFav;
  final ProductModel product;

  final bool inCart;

  @override
  Widget build(BuildContext context) {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : null,
          ),
          onPressed: () => productCubit.toggleFav(product),
        ),
        IconButton(
          icon: Icon(
            inCart ? Icons.check_circle : Icons.add_shopping_cart_outlined,
            color: inCart ? Colors.green : null,
          ),
          onPressed: () => productCubit.toggleBasket(product),
        ),
      ],
    );
  }
}
