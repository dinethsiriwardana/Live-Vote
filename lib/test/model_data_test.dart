// ignore_for_file: unused_import

import 'dart:convert';

import 'package:live_vote/data/model/answer_model.dart';
import 'package:live_vote/data/model/event_model.dart';
import 'package:live_vote/data/model/question_model.dart';
import 'package:live_vote/data/model/single_event_model.dart';
import 'package:live_vote/data/firebase/realtime_database.dart';

void modelrun() {
  Event event = Event(
    id: "dart_event",
    name: "Dart Language",
    description: "Explore the world of Dart programming.",
    host: "Dineth Siriwardana",
    live: 1,
  );
  // RealTimeDB().addEvent(event);

  List<Map> questions = [
    {
      "id": 1,
      "question": "What is Dart known for?",
      "answers": [
        {"id": 1, "answer": "Fast development", "noOfVotes": 0},
        {"id": 2, "answer": "Strong typing", "noOfVotes": 0},
        {"id": 3, "answer": "Cross-platform support", "noOfVotes": 0},
        {"id": 4, "answer": "Dynamic language features", "noOfVotes": 0}
      ]
    },
    {
      "id": 2,
      "question": "Which framework uses Dart?",
      "answers": [
        {"id": 1, "answer": "Flutter", "noOfVotes": 0},
        {"id": 2, "answer": "React Native", "noOfVotes": 0},
        {"id": 3, "answer": "Vue.js", "noOfVotes": 0},
        {"id": 4, "answer": "Angular", "noOfVotes": 0}
      ]
    },
    {
      "id": 3,
      "question": "What is Dart's package manager called?",
      "answers": [
        {"id": 1, "answer": "Pub", "noOfVotes": 0},
        {"id": 2, "answer": "DartGet", "noOfVotes": 0},
        {"id": 3, "answer": "PackageManager", "noOfVotes": 0},
        {"id": 4, "answer": "DartHub", "noOfVotes": 0}
      ]
    },
    {
      "id": 4,
      "question": "Which company developed Dart?",
      "answers": [
        {"id": 1, "answer": "Google", "noOfVotes": 0},
        {"id": 2, "answer": "Microsoft", "noOfVotes": 0},
        {"id": 3, "answer": "Apple", "noOfVotes": 0},
        {"id": 4, "answer": "Facebook", "noOfVotes": 0}
      ]
    },
    {
      "id": 5,
      "question": "What is Dart's primary use case?",
      "answers": [
        {"id": 1, "answer": "Web development", "noOfVotes": 0},
        {"id": 2, "answer": "Mobile app development", "noOfVotes": 0},
        {"id": 3, "answer": "Artificial intelligence", "noOfVotes": 0},
        {"id": 4, "answer": "Game development", "noOfVotes": 0}
      ]
    }
  ];

  for (var element in questions) {
    Question question = Question(
      id: element["id"],
      question: element["question"],
    );
    // RealTimeDB().addQuestion(event.id, question);

    for (var element in element['answers']) {
      Answer answer = Answer(
        id: element["id"],
        answer: element["answer"],
        noOfVotes: element["noOfVotes"],
      );
      // RealTimeDB().addAnswer(event.id, question.id, answer);
    }
  }
}
