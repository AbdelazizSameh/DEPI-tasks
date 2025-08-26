
import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:flutter/material.dart';

class PriceWithCheckoutButton extends StatelessWidget {
  const PriceWithCheckoutButton({super.key, required this.productProvider});

  final ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Total: \$${productProvider.getTotalPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => productProvider.removeAllInBasket(),
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
