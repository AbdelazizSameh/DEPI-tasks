import 'package:cart_and_wishlist_app_cubit/cubits/theme_cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightModeState());

  void toggleTheme() {
    if (state.isDark) {
      emit(LightModeState());
    } else {
      emit(DarkModeState());
    }
  }
}
