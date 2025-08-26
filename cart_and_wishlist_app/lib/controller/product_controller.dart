import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> favProducts = [];
  List<ProductModel> inBasketProducts = [];

  double totalPrice = 0;

  double get getTotalPrice => inBasketProducts.fold<double>(
    0.0,
    (total, element) => element.price + total,
  );

  void addRemoveFav(ProductModel product) {
    if (!favProducts.contains(product)) {
      favProducts.add(product);
    } else {
      favProducts.remove(product);
    }
    notifyListeners();
  }

  void addRemoveInBasket(ProductModel product) {
    if (!inBasketProducts.contains(product)) {
      inBasketProducts.add(product);
    } else {
      inBasketProducts.remove(product);
    }
    notifyListeners();
  }

  void removeAllInBasket() {
    inBasketProducts = [];
    notifyListeners();
  }
}
