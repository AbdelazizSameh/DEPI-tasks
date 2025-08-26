import 'package:cart_and_wishlist_app/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> favProducts = [];
  List<ProductModel> inBasketProducts = [];

  void addFav(ProductModel product) {
    favProducts.add(product);
    notifyListeners();
  }

  void addInBasket(ProductModel product) {
    inBasketProducts.add(product);
    notifyListeners();
  }

  void removeFav(ProductModel product) {
    favProducts.remove(product);
    notifyListeners();
  }

  void removeInBasket(ProductModel product) {
    inBasketProducts.remove(product);
    notifyListeners();
  }
}
