import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_quiz_app/models/questions.dart';
import 'package:my_quiz_app/screens/result_screen.dart';

import '../components/grad.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key, required this.tempsfinal, required this.questions})
      : super(key: key);
  final int tempsfinal;
  final List<Questions> questions;
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late int tempscourant;
  late Timer timer;
  late int indice = 0;
  String selectAnswer = '';
  int _score = 0;
  @override
  void initState() {
    super.initState();
    tempscourant = widget.tempsfinal;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        tempscourant = tempscourant - 1;
      });
      if (tempscourant == 0) {
        timer.cancel();
        pushResultScreen(context);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Curquestion = widget.questions[indice];
    return Scaffold(
      body: Grad(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                        value: tempscourant / widget.tempsfinal,
                      ),
                      Center(
                          child: Text(
                        tempscourant.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Question',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                Curquestion.question,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final answer = Curquestion.answers[indice];
                    return AnswerTile(
                      isSelected: answer == selectAnswer,
                      answer: answer,
                      correctAnswer: Curquestion.correctAnswer,
                      onTap: () {
                        setState(() {
                          selectAnswer = answer;
                        });

                        if (answer == Curquestion.correctAnswer) {
                          _score++;
                        }
                        Future.delayed(Duration(milliseconds: 200), () {
                          if (tempscourant == widget.questions.length - 1) {
                            pushResultScreen(context);
                            return;
                          }
                          setState(() {
                            tempscourant++;
                            selectAnswer = '';
                          });
                        });
                      },
                    );
                  },
                  itemCount: Curquestion.answers.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pushResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          questions: widget.questions,
          score: _score,
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  const AnswerTile({
    Key? key,
    required this.isSelected,
    required this.answer,
    required this.correctAnswer,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String answer;
  final String correctAnswer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          answer,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Color get cardColor {
    if (!isSelected) return Colors.white;

    if (answer == correctAnswer) {
      return Colors.teal;
    }
    return Colors.redAccent;
  }
}
