import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_state.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/in_basket_list_view_builder.dart';
import 'package:cart_and_wishlist_app_cubit/widgets/price_with_check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InBasketView extends StatelessWidget {
  const InBasketView({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = BlocProvider.of<ProductCubit>(context);
    final cartItems = productProvider.state.inBasketProducts;

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Expanded(
                      child: InBasketProductListViewBuilder(
                        cartItems: cartItems,
                        productCubit: productProvider,
                      ),
                    ),
                    PriceWithCheckoutButton(productCubit: productProvider),
                  ],
                );
              },
            ),
    );
  }
}
