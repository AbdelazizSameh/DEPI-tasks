import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/views/in_basket_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        CircleAvatar(
          backgroundColor: Colors.red,
          radius: 11,
          child: Text(
            Provider.of<ProductProvider>(
              context,
            ).inBasketProducts.length.toString(),
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
