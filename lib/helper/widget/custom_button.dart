import 'package:flutter/material.dart';

import 'custom_preloader.dart';
import 'neu_box.dart';


class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btText;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btText,
    required this.isLoading,
    this.height = 46,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: NeuBox(
        child: isLoading
            ? const SizedBox(
          child: FittedBox(
            child: CustomPreloader(
              whiteColor: false,
            ),
          ),
        )
            : FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              btText,
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xff2954FF),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}