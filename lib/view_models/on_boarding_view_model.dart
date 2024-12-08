import 'package:english_learning/helper/extension/string_extension.dart';
import 'package:flutter/material.dart';


class OnboardingViewModel {
  DateTime? currentBackPressTime;
  ValueNotifier currentIndex = ValueNotifier(0);

  OnboardingViewModel._init();

  static OnboardingViewModel? _instance;

  static OnboardingViewModel get instance {
    _instance ??= OnboardingViewModel._init();
    return _instance!;
  }

  OnboardingViewModel._dispose();

  static bool get dispose {
    _instance = null;
    return true;
  }

  void setNavIndex(int value) {
    if (value == currentIndex.value) {
      return;
    }
    currentIndex.value = value;
  }

  Future<bool> willPopFunction() async {
    if (currentIndex.value != 0) {
      currentIndex.value = 0;
      return Future.value(false);
    }

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      "Are you sure you want to exit?".showToast();
      return Future.value(false);
    }
    debugPrint("Closing app".toString());
    return Future.value(true);
  }
}
