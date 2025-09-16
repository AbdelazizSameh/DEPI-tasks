import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_expense/auth/google_auth.dart';
import 'package:firebase_auth_expense/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_sign_and_register_button.dart';
import '../widgets/custom_text_field.dart';
import 'home_view.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 80, color: Colors.deepPurple),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Welcome to FlutterFire, please sign in!",
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterView.id);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  CustomTextFormField(
                    onChanged: (emailValue) {
                      email = emailValue;
                    },
                    hintText: 'Email',
                    labelText: 'example@gmail.com',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    obsecureText: true,
                    onChanged: (passwordValue) {
                      password = passwordValue;
                    },
                    hintText: 'Password',
                    labelText: 'min length is 8',
                  ),

                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgotten password?",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  CustomSignAndRegisterButton(
                    text: 'Login',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await signInUser();
                          showSnackBar(context, message: 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              context,
                              message: 'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              message: 'Wrong password provided for that user.',
                            );
                          } else {
                            showSnackBar(context, message: e.code);
                          }
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  ),
                  CustomSignAndRegisterButton(
                    text: 'Login with google',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });
    try {
      final userCredential = await GoogleSignInService.signInWithGoogle();

      if (!mounted) return;
      if (userCredential != null) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
        showSnackBar(context, message: "Google Login failed");
      }
    } catch (e) {
      if (!mounted) return;
      // For error
      showSnackBar(context, message: "Google Login failed");
      print('Sign in error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
