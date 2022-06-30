import 'package:flutter/material.dart';
import 'package:myquizapp/models/questions.dart';

import 'quiz_screen.dart';

class CategoryScreen extends StatelessWidget {
  final List<Questions> questions;
  final int totalTime;
  const CategoryScreen({
    Key? key,
    required this.questions,
    required this.totalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a category',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryBox(
                  name: 'Sport',
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(
                          totalTime: totalTime,
                          questions: sportQuestion,
                        ),
                      ),
                    );
                  },
                  numberOfQuestion: sportQuestion.length,
                ),
                CategoryBox(
                  name: 'Education',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(
                          totalTime: totalTime,
                          questions: educationQuestion,
                        ),
                      ),
                    );
                  },
                  numberOfQuestion: educationQuestion.length,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryBox(
                  name: 'History',
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(
                          totalTime: totalTime,
                          questions: historyQuestion,
                        ),
                      ),
                    );
                  },
                  numberOfQuestion: historyQuestion.length,
                ),
                CategoryBox(
                  name: 'Monuments',
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz(
                          totalTime: totalTime,
                          questions: monumentsQuestion,
                        ),
                      ),
                    );
                  },
                  numberOfQuestion: monumentsQuestion.length,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Questions> get sportQuestion {
    return questions
        .where((question) => question.category == 'sports')
        .toList();
  }

  List<Questions> get educationQuestion {
    return questions
        .where((question) => question.category == 'education')
        .toList();
  }

  List<Questions> get historyQuestion {
    return questions
        .where((question) => question.category == 'history')
        .toList();
  }

  List<Questions> get monumentsQuestion {
    return questions
        .where((question) => question.category == 'monuments')
        .toList();
  }
}

class CategoryBox extends StatelessWidget {
  final String name;
  final Color color;
  final int numberOfQuestion;
  final Function() onPressed;
  const CategoryBox({
    Key? key,
    required this.name,
    required this.color,
    required this.numberOfQuestion,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 150,
        color: color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Text(
                numberOfQuestion.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
