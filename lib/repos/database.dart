import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class Database {
  final List<YearResult> main = [];

  initialize() {
    addDummyData();
  }

  addNewYear() {
    main.add(YearResult(year: main.length + 1));
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in main) {
      for (CourseResult course in year.firstSem.courseResults) {
        cumulativeScore += course.gpaScore!;
        cumulativeUnits += course.units;
      }
      for (CourseResult course in year.secondSem.courseResults) {
        cumulativeScore += course.gpaScore!;
        cumulativeUnits += course.units;
      }
    }
    // if cumulative units == 0, 0/0 = NaN
    return cumulativeUnits != 0
        ? double.parse((cumulativeScore / cumulativeUnits).toStringAsFixed(2))
        : 0;
  }

  addDummyData() {
    // add more dummy data
    addNewYear();
    addNewYear();
    addNewYear();
    addNewYear();
  }
}
