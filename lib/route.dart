import 'package:flutter/material.dart';
import 'package:live_vote/presentation/screens/admin/home/admin_home.dart';
import 'package:live_vote/presentation/screens/user/home/home.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const HomePage(),
  '/admin': (context) => const AdminHomePage(),
  // '/quiz': (context) => QuizPage(),
};
