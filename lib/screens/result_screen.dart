import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myquizapp/components/action_box.dart';
import 'package:myquizapp/components/grad.dart';
import 'package:myquizapp/models/questions.dart';
import 'package:myquizapp/screens/quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);
  final int score;
  final List<Questions> questions;
  final int totalTime;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Grad(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result : ${widget.score} / ${widget.questions.length}',
                style: TextStyle(
                    fontSize: 50,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 5
                      ..color = Colors.grey),
              ),
              SizedBox(height: 40),
              ActionButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Quiz(
                        totalTime: widget.totalTime,
                        questions: widget.questions,
                      ),
                    ),
                  );
                },
                title: 'Play Again',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _updateHighscore();
  }

  Future<void> _updateHighscore() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(authUser.uid);
    final userDoc = await userRef.get();
    if (userDoc.exists) {
      final user = userDoc.data();
      if (user == null) return;
      final lastGhighscore = user['score'];
      if (lastGhighscore >= widget.score) {
        return;
      }
      userRef.update({'score ': widget.score});
      return;
    }
    userRef.set({
      'email': authUser.email,
      'photoUrl': authUser.photoURL,
      'score': widget.score,
      'name': authUser.displayName
    });
  }
}
