import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomPreloader extends StatelessWidget {
  final bool whiteColor;
  final double? width;

  const CustomPreloader({
    super.key,
    this.whiteColor = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: whiteColor ? null : 60,
      alignment: Alignment.bottomCenter,
      child: LottieBuilder.asset(
          'assets/animations/${whiteColor ? 'preloader_white' : 'preloader1'}.json'),
    );
  }
}
