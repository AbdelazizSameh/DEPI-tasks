import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/widgets/productCard.dart';
import 'package:flutter/material.dart';

class ProductListViewBuilder extends StatelessWidget {
  const ProductListViewBuilder({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
