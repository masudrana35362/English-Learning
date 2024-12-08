import 'package:english_learning/service/dynamic/dynamics_service.dart';
import 'package:english_learning/themes/default_themes.dart';
import 'package:english_learning/views/home/home_view.dart';
import 'package:english_learning/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'helper/provider/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: Consumer<DynamicsService>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: DefaultThemes().themeData(context, provider),
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return const MyHomePage();
                  }
                  return const LoginView();
                }),
          );
        },
      ),
    );
  }
}
