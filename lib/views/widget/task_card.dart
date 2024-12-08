import 'package:english_learning/helper/widget/neu_box.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String headerText;
  final String descriptionText;

  const TaskCard({
    super.key,
    required this.headerText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      child:Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: "$headerText - ",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: descriptionText,
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
