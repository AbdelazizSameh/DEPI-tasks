import 'package:cart_and_wishlist_app/controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Center(
        child: ListTile(
          leading: Icon(Icons.dark_mode),
          title: Text("Dark mode"),
          trailing: Switch(
            value: themeProvider.isDark,
            onChanged: (value) => themeProvider.toggleTheme(),
          ),
        ),
      ),
    );
  }
}
