import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning/helper/widget/empty_spacer_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/widget/edit_word.dart';
import '../widget/task_card.dart';

class AllWordView extends StatelessWidget {
  const AllWordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmptySpace.emptyHeight(20),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('word')
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

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final wordData =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return GestureDetector(
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditWord(id: snapshot.data!.docs[index].id),
                        ),
                      );
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
    );
  }
}
