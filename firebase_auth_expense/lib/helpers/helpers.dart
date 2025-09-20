import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message}) {
  if (context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
