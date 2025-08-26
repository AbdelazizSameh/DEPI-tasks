import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/widgets/in_basket_list_view_builder.dart';
import 'package:cart_and_wishlist_app/widgets/price_with_check_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InBasketView extends StatelessWidget {
  const InBasketView({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartItems = productProvider.inBasketProducts;

    return Scaffold(
      appBar: AppBar(title: const Text("Cart"), centerTitle: true),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: InBasketProductListViewBuilder(
                    cartItems: cartItems,
                    productProvider: productProvider,
                  ),
                ),
                PriceWithCheckoutButton(productProvider: productProvider),
              ],
            ),
    );
  }
}
