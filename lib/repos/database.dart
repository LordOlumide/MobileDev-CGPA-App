import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class Database extends ChangeNotifier {
  final List<YearResult> _main = [];

  List<YearResult> get main => _main;

  initialize() {
    addDummyData();
  }

  addNewYear() {
    _main.add(YearResult(year: _main.length + 1));
    notifyListeners();
  }

  addCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
  }) {
    isFirstSemester == true
        ? _main[yearResultIndex].addCourseToFirstSem(newCourse)
        : _main[yearResultIndex].addCourseToSecondSem(newCourse);
    notifyListeners();
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in _main) {
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
