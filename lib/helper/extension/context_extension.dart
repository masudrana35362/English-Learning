import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/dynamic/dynamics_service.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;

  double get width => mediaQuery.size.width;

  double get paddingTop => mediaQuery.padding.top;

  double get lowValue => height * 0.01;

  double get normalValue => height * 0.02;

  double get mediumValue => height * 0.04;

  double get highValue => height * 0.1;
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;

  DynamicsService get dProvider =>
      Provider.of<DynamicsService>(this, listen: false);
}

extension PaddingExtensionAll on BuildContext {
  EdgeInsets get paddingLow => EdgeInsets.all(lowValue);

  EdgeInsets get paddingNormal => EdgeInsets.all(normalValue);

  EdgeInsets get paddingMedium => EdgeInsets.all(mediumValue);

  EdgeInsets get paddingHigh => EdgeInsets.all(highValue);
}

extension PaddingExtensionSymetric on BuildContext {
  EdgeInsets get paddingLowVertical => EdgeInsets.symmetric(vertical: lowValue);

  EdgeInsets get paddingNormalVertical =>
      EdgeInsets.symmetric(vertical: normalValue);

  EdgeInsets get paddingMediumVertical =>
      EdgeInsets.symmetric(vertical: mediumValue);

  EdgeInsets get paddingHighVertical =>
      EdgeInsets.symmetric(vertical: highValue);

  EdgeInsets get paddingLowHorizontal =>
      EdgeInsets.symmetric(horizontal: lowValue);

  EdgeInsets get paddingNormalHorizontal =>
      EdgeInsets.symmetric(horizontal: normalValue);

  EdgeInsets get paddingMediumHorizontal =>
      EdgeInsets.symmetric(horizontal: mediumValue);

  EdgeInsets get paddingHighHorizontal =>
      EdgeInsets.symmetric(horizontal: highValue);
}

extension PageExtension on BuildContext {
  Color get randomColor => Colors.primaries[Random().nextInt(17)];
}

extension DurationExtension on BuildContext {
  Duration get lowDuration => const Duration(milliseconds: 500);

  Duration get normalDuration => const Duration(seconds: 1);
}

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get bodySmall => textTheme.bodySmall?.copyWith(fontSize: 12);

  TextStyle? get bodyMedium => textTheme.bodyMedium?.copyWith(fontSize: 14);

  TextStyle? get bodyLarge => textTheme.bodyLarge?.copyWith(fontSize: 16);

  TextStyle? get titleSmall => textTheme.titleSmall?.copyWith(fontSize: 14);

  TextStyle? get titleMedium => textTheme.titleMedium?.copyWith(fontSize: 16);

  TextStyle? get titleLarge => textTheme.titleLarge?.copyWith(fontSize: 18);

  TextStyle? get labelSmall => textTheme.labelSmall?.copyWith(fontSize: 14);

  TextStyle? get labelMedium => textTheme.labelMedium?.copyWith(fontSize: 16);

  TextStyle? get labelLarge => textTheme.labelLarge?.copyWith(fontSize: 18);

  TextStyle? get headlineSmall =>
      textTheme.headlineSmall?.copyWith(fontSize: 16);

  TextStyle? get headlineMedium =>
      textTheme.headlineMedium?.copyWith(fontSize: 18);

  TextStyle? get headlineLarge =>
      textTheme.headlineLarge?.copyWith(fontSize: 20);
}

extension TurnTextBoldExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get bold6 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold5 => copyWith(fontWeight: FontWeight.w500);
}

extension NavigationExtension on BuildContext {
  toNamed(String routeName, {then, arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments).then((value) {
      then ??= () {};
      then();
    });
  }
}

extension RouteExtension on BuildContext {
  get arguments {
    return ModalRoute.of(this)?.settings.arguments;
  }

  toPopeNamed(String routeName, {then}) {
    Navigator.of(this).popAndPushNamed(routeName).then((value) {
      then ??= () {};
      then();
    });
  }

  toPage(Widget page, {then}) {
    Navigator.of(this)
        .push(MaterialPageRoute(
      builder: (context) => page,
    ))
        .then((value) {
      then ??= () {};
      then();
    });
  }

  toPopPage(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  paru(Widget page) {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(
          builder: (context) => page,
        ),
        (route) => false);
  }

  get popTrue => Navigator.pop(this, true);

  get popFalse => Navigator.pop(this, false);
}

extension ShowSnackBar on BuildContext {
  snackBar(String content,
      {String? buttonText,
      void Function()? onTap,
      Color? backgroundColor,
      Duration? duration}) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(5),
        backgroundColor: backgroundColor ?? dProvider.primaryColor,
        duration: duration ?? const Duration(seconds: 2),
        content: Row(
          children: [
            Text(
              content,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            if (buttonText != null)
              GestureDetector(
                onTap: onTap,
                child: Text(buttonText),
              )
          ],
        )));
  }
}

extension ShowLoader on BuildContext {
  Future<void> showLoader() {
    return showDialog(
      context: this,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
