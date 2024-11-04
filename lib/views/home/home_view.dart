import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../add_new.dart';
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

  @override
  Widget build(BuildContext context) {
    // Format the selected date
    final String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Words'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNewTask(),
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.add,
              ),
            ),
          ),
        ],
      ),
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
            const SizedBox(height: 10),
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

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final wordData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return TaskCard(
                      headerText: wordData['word'] ?? 'No Word',
                      descriptionText: wordData['meaning'] ?? 'No Meaning',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
