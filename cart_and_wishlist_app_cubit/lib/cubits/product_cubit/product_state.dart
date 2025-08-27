import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';

class ProductState {
  final List<ProductModel> favProducts;
  final List<ProductModel> inBasketProducts;

  ProductState({this.favProducts = const [], this.inBasketProducts = const []});
  double get totalPrice =>
      inBasketProducts.fold(0.0, (total, item) => total + item.price);
}
