import 'package:flutter/material.dart';
import 'package:my_quiz_app/components/action_box.dart';
import 'package:my_quiz_app/components/grad.dart';
import 'package:my_quiz_app/models/questions.dart';
import 'package:my_quiz_app/screens/quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    required this.score,
    required this.questions,
  }) : super(key: key);
  final int score;
  final List<Questions> questions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Grad(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result : $score / ${questions.length}}',
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
            SizedBox(height: 40),
            ActionButton(
              title: 'Play Again',
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
            )
          ],
        )),
      ),
    );
  }
}
