import 'package:flutter/material.dart';

class NeuBoxImage extends StatelessWidget {
  final Widget? child;
  final Color? color;

  const NeuBoxImage({super.key, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(100),
          border: color == null
              ? null
              : Border.all(
                  color: Colors.orange,
                  width: 1,
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),
            const BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset: Offset(-4, -4),
            )
          ]),
      padding: const EdgeInsets.all(5),
      child: child,
    );
  }
}
