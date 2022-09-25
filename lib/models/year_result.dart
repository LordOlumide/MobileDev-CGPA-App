import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';

class YearResult {
  int year;

  YearResult({required this.year});

  SemesterResult firstSem = SemesterResult();
  SemesterResult secondSem = SemesterResult();

  addCourseToFirstSem(CourseResult courseResult) {
    firstSem.add(courseResult);
  }

  addCourseToSecondSem(CourseResult courseResult) {
    secondSem.add(courseResult);
  }

  int get firstSemCourseNo => firstSem.courseResults.length;
  int get secondSemCourseNo => secondSem.courseResults.length;

  double get yearGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (CourseResult course in firstSem.courseResults) {
      cumulativeScore += course.gpaScore * course.units;
      cumulativeUnits += course.units;
    }
    for (CourseResult course in secondSem.courseResults) {
      cumulativeScore += course.gpaScore * course.units;
      cumulativeUnits += course.units;
    }
    // if cumulative units == 0, 0/0 = NaN
    return cumulativeUnits != 0
        ? double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2))
        : 0;
  }
}
