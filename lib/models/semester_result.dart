class SemesterResult {
  final Map<String, int> coursesAndScores;

  SemesterResult({required this.coursesAndScores});

  addToResult(String course, int score) {
    coursesAndScores[course] = score;
  }
}