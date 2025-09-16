import 'package:firebase_auth_expense/firebase_options.dart';
import 'package:firebase_auth_expense/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      initialRoute: LoginView.id,
      routes: {
        RegisterView.id: (context) => RegisterView(),
        LoginView.id: (context) => LoginView(),
      },
    );
  }
}
