class CourseResult {
  String courseName;
  String courseTitle;
  int marks;
  int units;
  int? gpaScore;
  String? grade;

  CourseResult({
    required this.courseName,
    required this.courseTitle,
    required this.marks,
    required this.units,
  }) {
    if (marks < 40) {
      grade = 'F';
      gpaScore = 0;
    } else if (marks < 45) {
      grade = 'E';
      gpaScore = 1;
    } else if (marks < 50) {
      grade = 'D';
      gpaScore = 2;
    } else if (marks < 60) {
      grade = 'C';
      gpaScore = 3;
    } else if (marks < 70) {
      grade = 'B';
      gpaScore = 4;
    } else {
      grade = 'A';
      gpaScore = 5;
    }
  }

  @override
  String toString() {
    return '{courseName: $courseName, courseTitle: $courseTitle, marks: $marks}';
  }
}
