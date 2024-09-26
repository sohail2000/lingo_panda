import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_panda/components/custom_text_field.dart';
import 'package:lingo_panda/presentation/screens/comments_screen.dart';
import 'package:lingo_panda/routing/routes.dart';
import 'package:lingo_panda/styling/custom_colors.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMessage = '';

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      print("Logged in as ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: CustomTextStyle.darkBlueBold24,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(emailController: _emailController, hintText: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(emailController: _passwordController, hintText: 'Password', obscureText: true,),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login().then((_) => context.go(Routes.comments));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.blue,
                textStyle: TextStyle(color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 12),
              ),
              child: const Text('Login'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMessage,
                    style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.go(Routes.signup);
              },
              child: const Text.rich(
                TextSpan(
                  text: 'New here? ',
                  children: [
                    TextSpan(
                        text: 'Signup', style: CustomTextStyle.darkBlueBold16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


