import 'package:flutter/material.dart';
import 'package:live_vote/data/model/single_event_model.dart';
import 'package:live_vote/presentation/screens/home/home.dart';
import 'package:live_vote/presentation/screens/quiz/quiz.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const HomePage(),
  // '/quiz': (context) => QuizPage(),
};
