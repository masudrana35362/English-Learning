import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/helper/widget/empty_spacer_helper.dart';
import 'package:english_learning/helper/widget/field_label.dart';
import 'package:english_learning/helper/widget/neu_box.dart';
import 'package:english_learning/helper/widget/text_field.dart';
import 'package:english_learning/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/widget/custom_button.dart';

class SignupView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupView(),
      );

  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier obscurePass = ValueNotifier<bool>(true);
  final ValueNotifier loadingSignIn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> createUserWithEmailAndPassword() async {
    loadingSignIn.value = true;

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // User created successfully
      print('User ID: ${userCredential.user?.uid}');
      // Here you might want to navigate to a different screen or show a success message
      await createUserInFirestore(
          userCredential.user?.uid, nameController.text.trim());
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      switch (e.code) {
        case 'weak-password':
          print('The password provided is too weak.');
          break;
        case 'email-already-in-use':
          print('The account already exists for that email.');
          break;
        case 'invalid-email':
          print('The email address is not valid.');
          break;
        default:
          print('Error: ${e.message}');
      }
    } catch (e) {
      // Handle any other errors
      print('An unexpected error occurred: $e');
    }

    loadingSignIn.value = false;
  }

  Future<void> createUserInFirestore(String? uid, String name) async {
    // Create a new user in Firestore
    // Here you can add more fields to the user document
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': emailController.text.trim(),
    });

    Navigator.pushAndRemoveUntil(context, LoginView.route(), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeuBox(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FieldLabel(
                      label: 'S I G N  U P',
                      fontSize: 22,
                    ),
                    EmptySpace.emptyHeight(20),
                    FieldWithLabel(
                        label: "Name",
                        hintText: "Enter your name",
                        controller: nameController),
                    FieldWithLabel(
                        label: "Email",
                        hintText: "Enter your email",
                        controller: emailController),
                    PassFieldWithLabel(
                      label: "Password",
                      hintText: "Enter your password",
                      valueListenable: obscurePass,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      svgPrefix: Icons.lock,
                      onFieldSubmitted: (value) {},
                    ),
                    EmptySpace.emptyHeight(20),
                    ValueListenableBuilder(
                      valueListenable: loadingSignIn,
                      builder: (context, value, child) => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            await createUserWithEmailAndPassword();
                          },
                          btText: 'S I G N  U P',
                          isLoading: value,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, LoginView.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
