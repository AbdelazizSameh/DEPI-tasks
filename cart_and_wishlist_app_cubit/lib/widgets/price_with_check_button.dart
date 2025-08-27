import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:flutter/material.dart';

class PriceWithCheckoutButton extends StatelessWidget {
  const PriceWithCheckoutButton({super.key, required this.productCubit});

  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Total: \$${productCubit.state.totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => productCubit.clearBasket(),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Checkout"),
          ),
        ],
      ),
    );
  }
}
