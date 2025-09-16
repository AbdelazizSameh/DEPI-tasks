import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helpers/helpers.dart';
import '../widgets/custom_sign_and_register_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static String id = 'RegisterView';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;
  String? password;
  bool isLoading = false;
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
                      Icon(
                        Icons.person_add,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create your account to get started!",
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginView.id);
                        },
                        child: const Text(
                          "Sign in",
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
                    onChanged: (String emailValue) {
                      email = emailValue;
                    },
                    hintText: 'Email',
                    labelText: 'example@gmail.com',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    obsecureText: true,
                    onChanged: (String passwordValue) {
                      password = passwordValue;
                    },
                    hintText: 'Password',
                    labelText: 'min length is 8',
                  ),

                  const SizedBox(height: 20),
                  CustomSignAndRegisterButton(
                    text: 'Register',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          showSnackBar(context, message: 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                              context,
                              message: 'The password provided is too weak.',
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(
                              context,
                              message:
                                  'The account already exists for that email.',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
