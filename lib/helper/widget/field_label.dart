import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';

class FieldLabel extends StatelessWidget {
  final String label;
  final double? fontSize;

  const FieldLabel({super.key, required this.label, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: context.titleMedium!.copyWith(
            fontSize: fontSize,
            color: context.dProvider.black80,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
