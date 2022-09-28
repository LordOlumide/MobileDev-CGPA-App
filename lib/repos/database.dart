import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import '../constants/dummy_courses.dart';
import 'hive_operations.dart';

class Database extends ChangeNotifier {
  final List<YearResult> _main = [];

  List<YearResult> get main => _main;

  Future<void> initialize() async {
    await addDummyData();

    await HiveOperations.runTest();

    // loadDataFromLocalMemory();
  }

  loadDataFromLocalMemory() {}

  addNewYear() {
    _main.add(YearResult(year: _main.length + 1));
    notifyListeners();
  }

  deleteYear({required int yearResultIndex}) {
    _main.removeAt(yearResultIndex);
    notifyListeners();
  }

  Future<void> addCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
  }) async {
    isFirstSemester == true
        ? _main[yearResultIndex].addCourseToFirstSem(newCourse)
        : _main[yearResultIndex].addCourseToSecondSem(newCourse);

    await HiveOperations.addCourseToLocalDatabase(
      yearResultIndex: yearResultIndex,
      isFirstSemester: isFirstSemester,
      newCourse: newCourse,
    );

    notifyListeners();
  }

  Future<void> editCourse({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) async {
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

  Future<void> deleteCourse({
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
  }) async {
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

  Future<void> addDummyData() async {
    await HiveOperations.clearPreviousCourses();
    // add more dummy data
    addNewYear();
    for (CourseResult dummyCourse in firstYear1) {
      await addCourse(
          newCourse: dummyCourse, yearResultIndex: 0, isFirstSemester: true);
    }
    for (CourseResult dummyCourse in firstYear2) {
      await addCourse(
          newCourse: dummyCourse, yearResultIndex: 0, isFirstSemester: false);
    }

    addNewYear();
    for (CourseResult dummyCourse in secondYear1) {
      await addCourse(
          newCourse: dummyCourse, yearResultIndex: 1, isFirstSemester: true);
    }
    for (CourseResult dummyCourse in secondYear2) {
      await addCourse(
          newCourse: dummyCourse, yearResultIndex: 1, isFirstSemester: false);
    }
  }
}
