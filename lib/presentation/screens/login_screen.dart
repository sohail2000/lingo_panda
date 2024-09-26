import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_panda/common_widgets/custom_button.dart';
import 'package:lingo_panda/common_widgets/custom_text_form_field.dart';
import 'package:lingo_panda/routing/routes.dart';
import 'package:lingo_panda/styling/custom_text_styles.dart';
import 'package:lingo_panda/utlis/form_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        print("Logged in as ${userCredential.user!.email}");
        context.go(Routes.comments);
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message!;
        });
      }
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Spacer(flex: 2),
              CustomTextField(
                emailController: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: FormValidator.validateEmail,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                emailController: _passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: FormValidator.validatePassword,
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red)),
                ),
              const Spacer(flex: 4),
              CustomButton(
                text: 'Login',
                onPressed: _login,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => context.go(Routes.signup),
                child: const Text.rich(
                  TextSpan(
                    text: 'New here? ',
                    style: CustomTextStyle.blackRegular14,
                    children: [
                      TextSpan(
                          text: 'Signup',
                          style: CustomTextStyle.darkBlueBold16),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
