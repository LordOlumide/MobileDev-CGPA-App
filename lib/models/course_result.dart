class CourseResult {
  String courseTitle;
  String courseDescription;
  int marks;
  int units;
  late int gpaScore;
  late String grade;

  CourseResult({
    required this.courseTitle,
    required this.courseDescription,
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

  replaceCourse({
    required CourseResult newCourse,
  }) {
    courseTitle = newCourse.courseTitle;
    courseDescription = newCourse.courseDescription;
    marks = newCourse.marks;
    units = newCourse.units;
    gpaScore = newCourse.gpaScore;
    grade = newCourse.grade;
  }

  @override
  String toString() {
    return '{courseName: $courseTitle, courseTitle: $courseDescription, marks: $marks,'
        ' units: $units, gpaScore: $gpaScore, grade: $grade}';
  }
}
