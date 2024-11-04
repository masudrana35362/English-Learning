import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditWord extends StatefulWidget {
  final String id;

  EditWord({super.key, required this.id});

  @override
  State<EditWord> createState() => _EditWordState();
}

class _EditWordState extends State<EditWord> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
        titleController.text =
            document['word']; // Adjust field names as necessary
        descriptionController.text =
            document['meaning']; // Adjust field names as necessary
      } else {
        // Handle document not found
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> updateTaskToDb() async {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Word',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Meaning',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await updateTaskToDb();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
