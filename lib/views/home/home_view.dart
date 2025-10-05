import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/views/home/widget/edit_word.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/date_selector.dart';
import '../widget/task_card.dart';

class MyHomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      );

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now().toUtc().add(const Duration(hours: 6));
  bool showAllDescriptions = true;
  List<bool> itemVisibilities = [];

  void _toggleAllDescriptions(bool value, int itemCount) {
    setState(() {
      showAllDescriptions = value;
      itemVisibilities = List<bool>.filled(itemCount, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected date
    final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DateSelector(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date; // Update the selected date
                });
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('word')
                  .where("createAt", isEqualTo: formattedDate)
                  .snapshots(),
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
                  return const Center(child: Text('No data here :('));
                }
                final itemCount = snapshot.data!.docs.length;
                if (itemVisibilities.length != itemCount) {
                  itemVisibilities = List<bool>.filled(itemCount, showAllDescriptions);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            showAllDescriptions ? Icons.visibility_off : Icons.remove_red_eye,
                            color: Colors.blue.shade600,
                          ),
                          onPressed: () {
                            _toggleAllDescriptions(!showAllDescriptions, itemCount);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final wordData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          return GestureDetector(
                            onLongPress: () {
                              _showOptions(context, snapshot.data!.docs[index].id);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: TaskCard(
                                headerText: wordData['word'] ?? 'No Word',
                                descriptionText: wordData['meaning'] ?? 'No Meaning',
                                showDescription: itemVisibilities[index],
                                onEyeTap: () {
                                  setState(() {
                                    itemVisibilities[index] = !itemVisibilities[index];
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // Makes it wrap the content height
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
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('word')
                    .doc(docId)
                    .delete();
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
