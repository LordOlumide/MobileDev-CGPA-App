import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';

class YearResult {
  int year;
  SemesterResult? firstSem;
  SemesterResult? secondSem;

  YearResult({required this.year});

  initFirstSem() {
    firstSem = SemesterResult();
  }

  addCourseToFirstSem(CourseResult courseResult) {
    firstSem!.add(courseResult);
  }

  double get yearGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    if (firstSem != null) {
      for (CourseResult course in firstSem!.courseResults) {
        cumulativeScore += course.gpaScore!;
        cumulativeUnits += course.units;
      }
    }
    if (secondSem != null) {
      for (CourseResult course in secondSem!.courseResults) {
        cumulativeScore += course.gpaScore!;
        cumulativeUnits += course.units;
      }
    }
    return double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2));
  }

  initSecondSem() {
    secondSem = SemesterResult();
  }

  addCourseToSecondSem(CourseResult courseResult) {
    secondSem!.add(courseResult);
  }
}