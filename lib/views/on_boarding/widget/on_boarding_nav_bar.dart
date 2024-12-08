import 'package:english_learning/helper/extension/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../view_models/on_boarding_view_model.dart';

class OnboardingNavBar extends StatelessWidget {
  const OnboardingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ov = OnboardingViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: ov.currentIndex,
      builder: (context, value, child) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedItemColor: context.dProvider.primaryColor,
        selectedIconTheme: IconThemeData(color: context.dProvider.primaryColor),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: value,
        onTap: (value) async {
          ov.setNavIndex(value);
        },
        items: items,
      ),
    );
  }

  List<BottomNavigationBarItem> get items => [
        bottomNavBarItem("Home", Icons.home, Icons.home),
        bottomNavBarItem("All Words", Icons.star, Icons.star),
      ];

  BottomNavigationBarItem bottomNavBarItem(
      String label, IconData iconNormal, IconData iconFilled) {
    return BottomNavigationBarItem(
        activeIcon: Icon(iconFilled, color: Colors.blue),
        icon: Icon(iconFilled, color: Colors.grey),
        label: label);
  }
}
