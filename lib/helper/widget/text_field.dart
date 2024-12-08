import 'package:flutter/material.dart';

import 'empty_spacer_helper.dart';
import 'field_label.dart';
import 'neu_box_field.dart';

class FieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final initialValue;
  final onChanged;
  final onFieldSubmitted;
  final String? Function(String?)? validator;
  final keyboardType;
  final textInputAction;
  final IconData? svgPrefix;
  final controller;
  final bool disabled;
  final double? height;

  const FieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.svgPrefix,
    this.disabled = false,
    this.controller,
    this.height,
  });

  setInitialValue(value) {
    if (value == null || value.isEmpty) {
      return;
    }

    controller?.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label),
        NeuBoxField(
          child: TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            controller: controller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                hintText: hintText,
                prefixIcon: svgPrefix != null ? Icon(svgPrefix) : null),
            onChanged: onChanged,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
        EmptySpace.emptyHeight(16),
      ],
    );
  }
}


class PassFieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final initialValue;
  final onChanged;
  final onFieldSubmitted;
  final validator;
  final keyboardType;
  final textInputAction;
  final IconData? svgPrefix;
  final controller;
  final valueListenable;

  const PassFieldWithLabel({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.svgPrefix,
    this.controller,
    this.valueListenable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label),
        ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, value, child) => TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            controller: controller,
            obscureText: value == true,
            decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: svgPrefix != null
                    ? Icon(svgPrefix)
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                suffixIcon: GestureDetector(
                  onTap: () => valueListenable.value = !(value == true),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: (value == true)
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                )),
            onChanged: onChanged,
            validator: validator ,
            onFieldSubmitted: onFieldSubmitted,
          ),
        )
      ],
    );
  }
}
