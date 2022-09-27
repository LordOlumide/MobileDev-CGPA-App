import 'package:mobile_dev_cgpa_app/utils/uuid_generator.dart';

class CourseResult {
  String? uniqueId;
  String courseTitle;
  String courseDescription;
  int marks;
  int units;
  late int gpaScore;
  late String grade;

  CourseResult({
    this.uniqueId,
    required this.courseTitle,
    required this.courseDescription,
    required this.marks,
    required this.units,
  }) {
    uniqueId ?? generateTimeBasedId();
    updateGradeAndGpaScore();
  }

  updateGradeAndGpaScore() {
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

  factory CourseResult.fromMap(Map<String, dynamic> json) =>
      CourseResult(
        uniqueId: json['uniqueId'],
        courseTitle: json['courseTitle'],
        courseDescription: json['courseDescription'],
        marks: json['marks'],
        units: json['units'],
      );

  Map<String, dynamic> toMap() =>
      {
        'uniqueId': uniqueId,
        'courseTitle': courseTitle,
        'courseDescription': courseDescription,
        'marks': marks,
        'units': units,
      };

  updateCourse({
    required CourseResult newCourse,
  }) {
    courseTitle = newCourse.courseTitle;
    courseDescription = newCourse.courseDescription;
    marks = newCourse.marks;
    units = newCourse.units;
    updateGradeAndGpaScore();
  }

  @override
  String toString() {
    return '{uniqueId: $uniqueId, courseTitle: $courseTitle, courseDesc: $courseDescription, '
        'marks: $marks, units: $units, gpaScore: $gpaScore, grade: $grade}';
  }
}
