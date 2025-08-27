import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_state.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/fav_product_list_view_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    final favItems = productCubit.state.favProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
        ],
      ),
      body: favItems.isEmpty
          ? const Center(child: Text("No items in wishlist"))
          : BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
              return FavProductListViewBuilder(
                  favItems: favItems,
                  productCubit: productCubit,
                );
            }
          ),
    );
  }
}
