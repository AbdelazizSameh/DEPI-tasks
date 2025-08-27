import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_state.dart';
import 'package:cart_and_wishlist_app_cubit/views/in_basket_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCartIcon extends StatelessWidget {
  const CustomCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return InBasketView();
                },
              ),
            );
          },
          icon: Icon(Icons.shopping_cart),
        ),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return CircleAvatar(
              backgroundColor: Colors.red,
              radius: 11,
              child: Text(
                state.inBasketProducts.length.toString(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}
