import 'package:live_vote/data/model/question_model.dart';

class Event {
  String id;
  String name;
  String description;
  String host;
  int live;
  List<Question>? questions;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.host,
    required this.live,
    this.questions,
  });

  factory Event.fromJson(Map<String, dynamic> json, List<Question> questions) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      host: json['host'],
      live: json['liveq'],
      questions: questions,
      // questions: List<Question>.from(
      //     json['qustions'].map((question) => Question.fromJson(question))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'host': host,
      'liveq': live,
      'questions': questions!.map((question) => question.toJson()).toList(),
    };
  }
}
