import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_state.dart';
import 'package:cart_and_wishlist_app_cubit/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState());

  void toggleFav(ProductModel product) {
    final favs = List<ProductModel>.from(state.favProducts);
    favs.contains(product) ? favs.remove(product) : favs.add(product);

    emit(
      ProductState(favProducts: favs, inBasketProducts: state.inBasketProducts),
    );
  }

  void toggleBasket(ProductModel product) {
    final basket = List<ProductModel>.from(state.inBasketProducts);
    basket.contains(product) ? basket.remove(product) : basket.add(product);

    emit(
      ProductState(favProducts: state.favProducts, inBasketProducts: basket),
    );
  }

  void clearBasket() {
    emit(ProductState(favProducts: state.favProducts, inBasketProducts: []));
  }

  void removeItemfromBasket(ProductModel product) {
    emit(
      ProductState(
        favProducts: state.favProducts,
        inBasketProducts: state.inBasketProducts..remove(product),
      ),
    );
  }

  void removeItemfromFav(ProductModel product) {
    emit(
      ProductState(
        favProducts: state.favProducts..remove(product),
        inBasketProducts: state.inBasketProducts,
      ),
    );
  }
}
