// import the material app package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/components/rank.dart';
import 'package:myquizapp/models/questions.dart';
import 'package:myquizapp/screens/quiz_screen.dart';
import 'package:myquizapp/components/grad.dart';
import 'package:myquizapp/components/action_box.dart';

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
                //on crée un stream builder pour récupérer les données de la base de données
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
                  print('got questions');
                  // ignore: dead_code
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('config')
                        .snapshots(),
                    builder: (context, snapshot) {
                      //print(!snapshot.error);
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final configDoc = snapshot.data!.docs.first.data()
                          as Map<String, dynamic>;
                      final totalTime = configDoc['key'];

                      return Column(
                        children: [
                          ActionButton(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Quiz(
                                    totalTime: totalTime,
                                    questions: questions,
                                  ),
                                ),
                              );
                            },
                            title: 'Start',
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Total Questions : ${questions.length}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 70),
              RankAuth()
            ],
          ),
        ),
      ),
    );
  }
}
