
import 'package:english_learning/helper/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultThemes {
  InputDecorationTheme? inputDecorationTheme(BuildContext context, dProvider) =>
      InputDecorationTheme(
          hintStyle: WidgetStateTextStyle.resolveWith((states) {
            return Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: dProvider.black40,
                  fontSize: 14,
                );
          }),
          counterStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return context.titleSmall!
                  .copyWith(color: dProvider.primaryColor);
            }
            return Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: dProvider.blackColor);
          }),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.black20, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.black10, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.redColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.redColor, width: 1),
          ),
          prefixIconColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.focused)) {
              return dProvider.primaryColor;
            }
            if (states.contains(WidgetState.error)) {
              return dProvider.redColor;
            }
            return dProvider.black40;
          }),
          suffixIconColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.focused)) {
                return dProvider.primaryColor;
              }
              if (states.contains(WidgetState.error)) {
                return dProvider.redColor;
              }
              return dProvider.black40;
            },
          ));

  CheckboxThemeData? checkboxTheme(dProvider) => CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          width: 1,
          color: dProvider.black20,
        ),
        fillColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return dProvider.secondaryColor;
          }
          return dProvider.whiteColor;
        }),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              width: 1,
              color: dProvider.secondaryColor,
            )),
      );

  RadioThemeData? radioThemeData(dProvider) => RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor:
            WidgetStateColor.resolveWith((states) => dProvider.secondaryColor),
        visualDensity: VisualDensity.compact,
      );

  OutlinedButtonThemeData? outlinedButtonTheme(dProvider) =>
      OutlinedButtonThemeData(
          style: ButtonStyle(
        overlayColor:
            WidgetStateColor.resolveWith((states) => Colors.transparent),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(
              color: dProvider.primaryColor,
            );
          }
          return BorderSide(
            color: dProvider.black20,
          );
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return dProvider.primaryColor;
          }
          return dProvider.black40;
        }),
      ));

  ElevatedButtonThemeData? elevatedButtonTheme(dProvider) =>
      ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) => 0),
        overlayColor:
            WidgetStateColor.resolveWith((states) => Colors.transparent),
        shape: WidgetStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return dProvider.primaryColor.withOpacity(.05);
          }
          if (states.contains(WidgetState.pressed)) {
            return dProvider.blackColor;
          }
          return dProvider.primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return dProvider.black40;
          }
          if (states.contains(WidgetState.pressed)) {
            return dProvider.whiteColor;
          }
          return dProvider.whiteColor;
        }),
      ));

  TextButtonThemeData? textButtonThemeData(dProvider) => TextButtonThemeData(
          style: ButtonStyle(
        elevation: WidgetStateProperty.resolveWith((states) => 0),
        overlayColor:
            WidgetStateColor.resolveWith((states) => Colors.transparent),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return dProvider.blackColor.withOpacity(0.0);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return dProvider.black40;
          }
          if (states.contains(WidgetState.pressed)) {
            return dProvider.blackColor;
          }
          return dProvider.primaryColor;
        }),
      ));

  appBarTheme(BuildContext context) => AppBarTheme(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: context.dProvider.blackColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: context.titleLarge?.bold6,
        surfaceTintColor: context.dProvider.whiteColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      );

  TextSelectionThemeData textSelectionThemeData(BuildContext context) =>
      TextSelectionThemeData(
          cursorColor: context.dProvider.primaryColor,
          selectionColor: context.dProvider.primary40,
          selectionHandleColor: context.dProvider.primaryColor);

  PopupMenuThemeData popupMenuThemeData(BuildContext context) =>
      PopupMenuThemeData(
        color: context.dProvider.whiteColor,
      );

  themeData(BuildContext context, dProvider) => ThemeData(
      colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        inversePrimary: Colors.grey.shade900,
      ),
     primaryColor: dProvider.primaryColor,
      scaffoldBackgroundColor: Colors.grey.shade500,
      scrollbarTheme: scrollbarTheme(dProvider),
      useMaterial3: true,
      popupMenuTheme: popupMenuThemeData(context),
      textSelectionTheme: textSelectionThemeData(context),
      appBarTheme: DefaultThemes().appBarTheme(context),
      elevatedButtonTheme: elevatedButtonTheme(dProvider),
      outlinedButtonTheme: outlinedButtonTheme(dProvider),
      inputDecorationTheme: inputDecorationTheme(context, dProvider),
      checkboxTheme: checkboxTheme(dProvider),
      textButtonTheme: textButtonThemeData(dProvider),
      switchTheme: switchThemeData(dProvider),
      dialogTheme: DialogTheme(
        surfaceTintColor: dProvider.whiteColor,
        backgroundColor: dProvider.whiteColor,
      ));
}

SwitchThemeData switchThemeData(dProvider) => SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return dProvider.primary10;
        }
        return dProvider.whiteColor;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (!states.contains(WidgetState.selected)) {
          return dProvider.redColor.withOpacity(.60);
        }
        return dProvider.greenColor.withOpacity(.60);
      }),
      trackOutlineColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (!states.contains(WidgetState.selected)) {
          return dProvider.redColor.withOpacity(.60);
        }
        return dProvider.greenColor.withOpacity(.40);
      }),
    );

ScrollbarThemeData scrollbarTheme(dProvider) => ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.scrolledUnder)) {
          return true;
        }
        return false;
      }),
      thickness: WidgetStateProperty.resolveWith((states) => 6),
      thumbColor:
          WidgetStateProperty.resolveWith((states) => dProvider.primary60),
    );
