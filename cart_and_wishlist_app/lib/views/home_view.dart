import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/views/fav_view.dart';
import 'package:cart_and_wishlist_app/widgets/custom_cart_icon.dart';
import 'package:cart_and_wishlist_app/widgets/product_card_list_view_builder.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final List<ProductModel> dummyProducts = const [
    ProductModel(name: 'Wireless Headphones', price: 99.99),
    ProductModel(name: 'Gaming Laptop', price: 1299.00),
    ProductModel(name: 'Smartphone', price: 799.99),
    ProductModel(name: 'Smartwatch', price: 199.99),
    ProductModel(name: 'Bluetooth Speaker', price: 59.99),
    ProductModel(name: 'Mechanical Keyboard', price: 149.99),
    ProductModel(name: '4K Monitor', price: 399.00),
    ProductModel(name: 'Wireless Mouse', price: 49.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FavView();
                  },
                ),
              );
            },
            icon: Icon(Icons.favorite),
          ),
          CustomCartIcon(),
        ],
      ),
      body: ProductListViewBuilder(products: dummyProducts),
    );
  }
}
