import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../helper/widget/custom_button.dart';
import '../../../helper/widget/empty_spacer_helper.dart';
import '../../../helper/widget/text_field.dart';

class EditWord extends StatefulWidget {
  final String id;

  const EditWord({super.key, required this.id});

  @override
  State<EditWord> createState() => _EditWordState();
}

class _EditWordState extends State<EditWord> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('word') // Replace 'words' with your collection name
          .doc(widget.id)
          .get();

      if (document.exists) {
        titleController.text = document['word']; // Adjust field names as necessary
        descriptionController.text = document['meaning']; // Adjust field names as necessary
      } else {
        // Handle document not found
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> updateTaskToDb() async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('word') // Replace 'words' with your collection name
          .doc(widget.id)
          .update({
        'word': titleController.text,
        'meaning': descriptionController.text,
      });
      isLoading.value = false;
      // Optionally show a success message or navigate back
      Navigator.pop(context);
    } catch (e) {
      print('Error updating document: $e');
      // Handle error (e.g., show an error message)
    }

  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('E D I T  W O R D'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                builder: (BuildContext context, bool value, Widget? child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: CustomButton(
                        onPressed: () async {
                          await updateTaskToDb();
                        },
                        btText: 'U P D A T E',
                        isLoading: value),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
