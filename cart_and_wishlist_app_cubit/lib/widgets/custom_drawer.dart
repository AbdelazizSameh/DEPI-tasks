import 'package:cart_and_wishlist_app_cubit/cubits/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Drawer(
      child: Center(
        child: ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text("Dark mode"),
          trailing: Switch(
            value: themeCubit.state.isDark,
            onChanged: (value) => themeCubit.toggleTheme(),
          ),
        ),
      ),
    );
  }
}
