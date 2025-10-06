import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/widget/custom_button.dart';
import '../../helper/widget/empty_spacer_helper.dart';
import '../../helper/widget/field_label.dart';
import '../../helper/widget/neu_box.dart';
import '../../helper/widget/text_field.dart';
import '../on_boarding/on_boarding_view.dart';
import '../signup/signup_view.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier obscurePass = ValueNotifier<bool>(true);
  final ValueNotifier loadingSignIn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUserWithEmailAndPassword() async {
    loadingSignIn.value = true;
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user == null) {
        return;
      }
      Navigator.pushAndRemoveUntil(
          context, OnboardingView.route(), (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    loadingSignIn.value = false;
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
                      label: 'S I G N  I N',
                      fontSize: 22,
                    ),
                    EmptySpace.emptyHeight(20),
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
                            await loginUserWithEmailAndPassword();
                          },
                          btText: 'S I G N  I N',
                          isLoading: value,
                        ),
                      ),
                    ),
                    EmptySpace.emptyHeight(20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignupView.route());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
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
            ),
          ],
        ),
      ),
    );
  }
}
