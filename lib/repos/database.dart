import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import '../repos/dummy_courses.dart';

class Database extends ChangeNotifier {
  final List<YearResult> _main =
      []; // TODO: Implement Delete course and last year

  List<YearResult> get main => _main;

  initialize() {
    addNewYear();
    addDummyData();
  }

  addNewYear() {
    _main.add(YearResult(year: _main.length + 1));
    notifyListeners();
  }

  deleteYear({required int yearResultIndex}) {
    _main.removeAt(yearResultIndex);
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

  editCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) {
    isFirstSemester == true
        ? _main[yearResultIndex]
            .firstSem
            .courseResults[courseResultIndex]
            .updateCourse(newCourse: newCourse)
        : _main[yearResultIndex]
            .secondSem
            .courseResults[courseResultIndex]
            .updateCourse(newCourse: newCourse);
    notifyListeners();
  }

  deleteCourse({
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) {
    isFirstSemester == true
        ? _main[yearResultIndex].firstSem.removeCourse(courseResultIndex)
        : _main[yearResultIndex].secondSem.removeCourse(courseResultIndex);
    notifyListeners();
  }

  double get currentCGPA {
    int cumulativeScore = 0;
    int cumulativeUnits = 0;
    for (YearResult year in _main) {
      for (CourseResult course in year.firstSem.courseResults) {
        cumulativeScore += course.gpaScore * course.units;
        cumulativeUnits += course.units;
      }
      for (CourseResult course in year.secondSem.courseResults) {
        cumulativeScore += course.gpaScore * course.units;
        cumulativeUnits += course.units;
      }
    }
    // if cumulative units == 0, 0/0 = NaN
    return cumulativeUnits != 0 ? cumulativeScore / cumulativeUnits : 0;
  }

  addDummyData() {
    // add more dummy data
    addNewYear();
    for (CourseResult dummyCourse in firstYear1) {
      addCourse(
          newCourse: dummyCourse, yearResultIndex: 0, isFirstSemester: true);
    }
    for (CourseResult dummyCourse in firstYear2) {
      addCourse(
          newCourse: dummyCourse, yearResultIndex: 0, isFirstSemester: false);
    }
    addNewYear();
    for (CourseResult dummyCourse in secondYear1) {
      addCourse(
          newCourse: dummyCourse, yearResultIndex: 1, isFirstSemester: true);
    }
    for (CourseResult dummyCourse in secondYear2) {
      addCourse(
          newCourse: dummyCourse, yearResultIndex: 1, isFirstSemester: false);
    }
  }
}
