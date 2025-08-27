import 'package:cart_and_wishlist_app_cubit/cubits/product_cubit/product_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/theme_cubit/theme_state.dart';
import 'package:cart_and_wishlist_app_cubit/cubits/theme_cubit/theme_cubit.dart';
import 'package:cart_and_wishlist_app_cubit/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.themData,
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          home: HomeView(),
          themeAnimationCurve: Curves.easeOutQuint,
          themeAnimationDuration: Duration(milliseconds: 200),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
