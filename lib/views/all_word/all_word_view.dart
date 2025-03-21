import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/helper/widget/empty_spacer_helper.dart';
import 'package:english_learning/helper/widget/field_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/widget/edit_word.dart';
import '../widget/task_card.dart';

class AllWordView extends StatelessWidget {
  const AllWordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EmptySpace.emptyHeight(20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('word').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error occurred!'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: FieldLabel(label: 'No data here :(')),
                  ],
                );
              }
      
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final wordData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    final docId = snapshot.data!.docs[index].id;
              
                    return GestureDetector(
                      onLongPress: () {
                        _showOptions(context, docId);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: TaskCard(
                          headerText: wordData['word'] ?? 'No Word',
                          descriptionText: wordData['meaning'] ?? 'No Meaning',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext context, String docId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  Column(
                      mainAxisSize: MainAxisSize.min, // Makes it wrap the content height
                      children: [
                        EditWord(id: docId),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _showDeleteConfirmation(context, docId);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this word?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('word').doc(docId).delete();
                Navigator.pop(context); // Close the dialog
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
