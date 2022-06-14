// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Questions {
  final String id;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String imageUrl;
  Questions(
      {required this.id,
      required this.question,
      required this.answers,
      required this.correctAnswer,
      required this.imageUrl});

  Questions copyWith({
    String? id,
    String? question,
    List<String>? answers,
    String? correctAnswer,
    String? imageUrl,
  }) {
    return Questions(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answers': answers,
      'correctAnswer': correctAnswer,
      'imageUrl': imageUrl,
    };
  }

  factory Questions.fromMap(Map<String, dynamic> map) {
    print(map);
    return Questions(
      id: map['id'] as String,
      question: map['question'] as String,
      answers: List<String>.from((map['answers'])),
      correctAnswer: map['correctAnswer'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
  factory Questions.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    final id = snapshot.id;
    data['id'] = id;

    return Questions.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  factory Questions.fromJson(String source) =>
      Questions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Questions(id: $id, question: $question, answers: $answers, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Questions &&
        other.id == id &&
        other.question == question &&
        listEquals(other.answers, answers) &&
        other.correctAnswer == correctAnswer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answers.hashCode ^
        correctAnswer.hashCode;
  }
}

//  List<Questions> question = [
//   Questions(
//       id: '1',
//       question: 'c quoi la question?',
//       answers: ['1', '2', '3', '4'],
//       correctAnswer: '2'),
//   Questions(
//       id: '2',
//       question: 'c quoi la questisseeon',
//       answers: ['1', '2', '3', '4'],
//       correctAnswer: '4'),
//   Questions(
//       id: '3',
//       question: 'c quoi la questieeon',
//       answers: ['1', '2', '3', '4'],
//       correctAnswer: '1'),
//   Questions(
//       id: '4',
//       question: 'c quoi la queiistion',
//       answers: ['1', '2', '3', '4'],
//       correctAnswer: '3'),
// ];
