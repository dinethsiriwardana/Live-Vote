import 'package:live_vote/data/model/answer_model.dart';

class Question {
  int id;
  String question;
  List<Answer>? answers;

  Question({
    required this.id,
    required this.question,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json, List<Answer> answers) {
    return Question(
        id: json['id'],
        question: json['question'],
        // answers: List<Answer>.from(
        //     json['answers'].map((answer) => Answer.fromJson(answer))),
        answers: answers);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answers': answers!.map((answer) => answer.toJson()).toList(),
    };
  }
}
