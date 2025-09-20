import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_expense/firebase_options.dart';
import 'package:firebase_auth_expense/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'database/hive_db.dart';
import 'views/home_view.dart';
import 'views/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await ExpenseDbHive.initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasData) {
            return const HomeView();
          }

          return const LoginView();
        },
      ),

      routes: {
        RegisterView.id: (context) => RegisterView(),
        LoginView.id: (context) => LoginView(),
        HomeView.id: (context) => HomeView(),
      },
    );
  }
}
