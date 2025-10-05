import 'package:english_learning/helper/widget/neu_box.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String headerText;
  final String descriptionText;
  final bool showDescription;
  final VoidCallback onEyeTap;

  const TaskCard({
    super.key,
    required this.headerText,
    required this.descriptionText,
    required this.showDescription,
    required this.onEyeTap,
  });

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: headerText,
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    if (showDescription)
                      TextSpan(
                        text: " - $descriptionText",
                        style: TextStyle(color: Colors.blue.shade600, fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                showDescription ? Icons.visibility_off : Icons.remove_red_eye,
                color: Colors.blue.shade600,
              ),
              onPressed: onEyeTap,
            ),
          ],
        ),
      ),
    );
  }
}
