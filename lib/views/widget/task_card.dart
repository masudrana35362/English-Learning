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
                    style:  TextStyle(
                        color: Colors.blue.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: descriptionText,
                    style:  TextStyle(color: Colors.blue.shade600, fontSize: 16),
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
