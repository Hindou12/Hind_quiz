import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_app/models/questions.dart';
import 'package:my_quiz_app/screens/result_screen.dart';

import '../components/grad.dart';

class Quiz extends StatefulWidget {
  const Quiz({
    Key? key,
    required this.totalTime,
    required this.questions,
  }) : super(key: key);
  final int totalTime;
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
    tempscourant = widget.totalTime;
    timer = Timer.periodic(Duration(seconds: 2),
        (timer) //2secondes pour chaque 1 sec
        {
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
    final Curquestion = widget.questions[indice]; //on récupère la question
    print(Curquestion.imageUrl); //on affiche l'image
    return Scaffold(
      //on crée le scaffold
      body: Grad(
        //on crée le gradient
        child: Padding(
          //on crée le padding
          padding: const EdgeInsets.all(16.0),
          child: Column(
            //on crée la colonne
            crossAxisAlignment: CrossAxisAlignment.start, //on aligne la colonne
            children: [
              //on crée les enfants
              SizedBox(
                //on crée un sizedbox
                height: 40, //on définit la hauteur
              ),
              SizedBox(
                height: 30,
                child: ClipRRect(
                  //on crée un cliprect
                  borderRadius:
                      BorderRadius.circular(20), //on définit le radius
                  child: Stack(
                    //on crée un stack
                    fit: StackFit.expand, //on définit la taille
                    children: [
                      LinearProgressIndicator(
                        //on crée un linearprogressindicator
                        value: tempscourant /
                            widget.totalTime, //on définit la valeur du temps
                      ),
                      Center(
                          //on crée un center
                          child: Text(
                        tempscourant.toString(), //on affiche le temps
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
                Curquestion.question,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              //Spacer(),
              // Image.network(Curquestion.imageUrl),
              CachedNetworkImage(
                imageUrl: Curquestion.imageUrl,
                height: 200,
                width: 500,
              ), //ajouter la photo
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final answer =
                        Curquestion.answers[index]; //on récupère la réponse
                    return AnswerTile(
                      isSelected: answer ==
                          selectAnswer, //on définit si la réponse est sélectionnée
                      answer: answer, //on définit la réponse
                      correctAnswer: Curquestion
                          .correctAnswer, //on définit la réponse correcte
                      onTap: () {
                        //on définit l'action lorsque l'on clique
                        setState(() {
                          selectAnswer =
                              answer; //on définit la réponse sélectionnée
                        });

                        if (answer == Curquestion.correctAnswer) {
                          //on définit si la réponse est correcte
                          _score++; // on incrémente le score quand c correct
                        }
                        Future.delayed(Duration(milliseconds: 500), () {
                          if (indice == widget.questions.length - 1) {
                            //on définit si on est à la dernière question
                            pushResultScreen(
                                context); //on pousse la page de résultat
                            return;
                          }
                          setState(() {
                            indice++; //on incrémente l'indice
                            selectAnswer =
                                ''; //on définit la réponse sélectionnée à vide
                          });
                        });
                      },
                    );
                  },
                  itemCount: Curquestion
                      .answers.length, //on définit le nombre de réponses
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
      //on pousse la page de résultat
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          //on crée la page de résultat
          questions: widget.questions, //on définit les questions
          totalTime: widget.totalTime, //on définit le temps total
          score: _score, //on définit le score
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
    //on définit la couleur de la carte
    if (!isSelected) return Colors.white; //si la réponse n'est pas sélectionnée

    if (answer == correctAnswer) {
      //si la réponse est correcte
      return Colors.teal; //vert
    }
    return Colors.redAccent; //sinon c pas correct c le rouge
  }
}
