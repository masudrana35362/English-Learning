import 'package:english_learning/views/all_word/all_word_view.dart';
import 'package:english_learning/views/on_boarding/widget/on_boarding_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view_models/on_boarding_view_model.dart';
import '../add_word/add_new.dart';
import '../home/home_view.dart';
import '../home/widget/my_drawer.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "landing";
  static route() => MaterialPageRoute(
    builder: (context) => const OnboardingView(),
  );

  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final ov = OnboardingViewModel.instance;
    final widgets = [
      const MyHomePage(),
      const AllWordView(),
    ];

    final appBars = [
      const Text('H O M E'),
      const Text('M Y  W O R D S'),
    ];

    return WillPopScope(
      onWillPop: ov.willPopFunction,
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: ov.currentIndex,
            builder: (context, value, child) => appBars[value],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNewTask(),
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.add,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: const MyDrawer(),
        body: ValueListenableBuilder(
          valueListenable: ov.currentIndex,
          builder: (context, value, child) => widgets[value],
        ),
        bottomNavigationBar: const OnboardingNavBar(),
      ),
    );
  }
}
