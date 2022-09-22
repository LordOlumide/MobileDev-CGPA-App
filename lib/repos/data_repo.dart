import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class BaseRepo {
  final List<YearResult> main = [];

  addNewYear() {
    main.add(YearResult(year: main.length + 1));
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in main) {
      if (year.firstSem != null) {
        for (CourseResult course in year.firstSem!.courseResults) {
          cumulativeScore += course.gpaScore!;
          cumulativeUnits += course.units;
        }
      }
      if (year.secondSem != null) {
        for (CourseResult course in year.secondSem!.courseResults) {
          cumulativeScore += course.gpaScore!;
          cumulativeUnits += course.units;
        }
      }
    }
    return double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2));
  }

  addDummyData() { // add more dummy data
    addNewYear();
  }

}
