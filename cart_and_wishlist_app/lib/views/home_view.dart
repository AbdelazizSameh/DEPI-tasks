import 'package:cart_and_wishlist_app/controller/product_controller.dart';
import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:cart_and_wishlist_app/views/fav_view.dart';
import 'package:cart_and_wishlist_app/views/in_basket_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  final List<ProductModel> dummyProducts = const [
    ProductModel(name: 'Wireless Headphones', price: '\$99.99'),
    ProductModel(name: 'Gaming Laptop', price: '\$1299.00'),
    ProductModel(name: 'Smartphone', price: '\$799.99'),
    ProductModel(name: 'Smartwatch', price: '\$199.99'),
    ProductModel(name: 'Bluetooth Speaker', price: '\$59.99'),
    ProductModel(name: 'Mechanical Keyboard', price: '\$149.99'),
    ProductModel(name: '4K Monitor', price: '\$399.00'),
    ProductModel(name: 'Wireless Mouse', price: '\$49.99'),
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
          Stack(
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
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, size: 40),
              title: Text(dummyProducts[index].name),
              subtitle: Text(
                dummyProducts[index].price,
                style: TextStyle(fontSize: 16),
              ),
              trailing: Consumer<ProductProvider>(
                builder: (context, product, _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (product.favProducts.contains(
                            dummyProducts[index],
                          )) {
                            product.removeFav(dummyProducts[index]);
                          } else {
                            product.addFav(dummyProducts[index]);
                          }
                        },

                        child:
                            product.favProducts.contains(dummyProducts[index])
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_outline),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (product.inBasketProducts.contains(
                            dummyProducts[index],
                          )) {
                            product.removeInBasket(dummyProducts[index]);
                          } else {
                            product.addInBasket(dummyProducts[index]);
                          }
                        },
                        child:
                            product.inBasketProducts.contains(
                              dummyProducts[index],
                            )
                            ? Icon(Icons.done, color: Colors.green)
                            : Icon(Icons.add_shopping_cart_outlined),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
