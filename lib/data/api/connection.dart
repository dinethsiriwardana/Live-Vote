class ApiPath {
  static String answerPath(String eventname, int qName) =>
      '/events/$eventname/questions/$qName/answers/';
  static String selectedAnswerPath(String eventname, int qName, int anw) =>
      '/events/$eventname/questions/$qName/answers/';
  static String changeLiveQuizPath(String eventname) => '/events/';
  static String queAllPath(String eventname) => '/events/$eventname/questions/';
}
