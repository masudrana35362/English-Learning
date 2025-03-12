import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/helper/widget/custom_button.dart';
import 'package:english_learning/helper/widget/empty_spacer_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helper/widget/text_field.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  Future<void> uploadTaskToDb() async {
    isLoading.value = true;
    try {
      final nowInDhaka = DateTime.now().toUtc().add(const Duration(hours: 6));
      final String formattedDate = DateFormat('dd-MM-yyyy').format(nowInDhaka);

      log(formattedDate);

      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("word").doc().set({
        "word": titleController.text.trim(),
        "meaning": descriptionController.text.trim(),
        "createAt": formattedDate,
      });
      isLoading.value = false;
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('A D D N E W W O R D', style: TextStyle(fontSize: 20)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          FieldWithLabel(
            label: 'Word',
            hintText: 'Word',
            controller: titleController,
          ),
          FieldWithLabel(
            label: 'Meaning',
            hintText: 'Meaning',
            controller: descriptionController,
            maxLines: 3,
          ),
          EmptySpace.emptyHeight(20),
          ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, child) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                      onPressed: () async {
                        if (titleController.text.trim().isEmpty || descriptionController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill all the fields'),
                            ),
                          );
                          return;
                        }

                        await uploadTaskToDb();
                      },
                      btText: 'SUBMIT',
                      isLoading: value),
                );
              })
        ],
      ),
    );
  }
}
