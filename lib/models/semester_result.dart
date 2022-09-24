import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class SemesterResult {
  final List<CourseResult> courseResults = [];

  void add(CourseResult courseResult) {
    courseResults.add(courseResult);
  }


  int get totalNoOfCourses {
    return courseResults.length;
  }

  int get totalNoOfUnits {
    int nOOfUnits = 0;
    for (CourseResult course in courseResults) {
      nOOfUnits += course.units;
    }
    return nOOfUnits;
  }

  double get semesterGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (CourseResult course in courseResults) {
      cumulativeScore += course.gpaScore!;
      cumulativeUnits += course.units;
    }
    return cumulativeUnits != 0
        ? double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2))
        : 0;
  }

  @override
  String toString() {
    return 'Semester Results: ${courseResults.map((e) => e.toString())}';
  }
}
