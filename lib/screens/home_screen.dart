// import the material app package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/models/questions.dart';
import 'package:my_quiz_app/screens/quiz_screen.dart';
import 'package:my_quiz_app/components/grad.dart';
import 'package:my_quiz_app/components/action_box.dart';

// create the HomeScreen widget
// parent widget and all the functions and variables will be in this widget so we will need to change state of our widget.
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Grad(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/quiz.png',
                width: 300,
                height: 200,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final questionDocs = snapshot.data!.docs;
                  final questions = questionDocs
                      .map((e) => Questions.fromQueryDocumentSnapshot(e))
                      .toList();

                  return ActionButton(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Quiz(
                            tempsfinal: 10,
                            questions: questions,
                          ),
                        ),
                      );
                    },
                    title: 'Start',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
