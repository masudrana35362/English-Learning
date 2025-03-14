import 'package:english_learning/helper/widget/empty_spacer_helper.dart';
import 'package:english_learning/helper/widget/neu_box_image.dart';
import 'package:flutter/material.dart';

import '../../helper/widget/neu_box.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('A B O U T', style: TextStyle(fontSize: 20)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),
          EmptySpace.emptyHeight(10),
          NeuBoxImage(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/about_image.jpg'),
                  ),
                ),
              )),
          EmptySpace.emptyHeight(20),
          const NeuBox(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text('English Learning App', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Version: 1.0.0'),
                  Text('Developer: Md Masud Rana'),
                  Text('Email: dev.mdmasudrana@gmail.com'),
                  Text('Phone: +880 1720515259'),
                  Text('Copyright @ 2025', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          EmptySpace.emptyHeight(20),
        ],
      ),
    );
  }
}
