class Answer {
  int id;
  String answer;
  int noOfVotes;

  Answer({
    required this.id,
    required this.answer,
    required this.noOfVotes,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      answer: json['answer'],
      noOfVotes: json['noOfVotes'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'noOfVotes': noOfVotes,
    };
  }
}
