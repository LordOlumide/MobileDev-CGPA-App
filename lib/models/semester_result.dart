import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class SemesterResult {
  final List<CourseResult> courseResults = [];

  void add(CourseResult courseResult) {
    courseResults.add(courseResult);
  }

  double get semesterGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (CourseResult course in courseResults) {
      cumulativeScore += course.gpaScore!;
      cumulativeUnits += course.units;
    }
    return double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2));
  }

}