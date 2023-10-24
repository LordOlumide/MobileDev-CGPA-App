import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import '../constants/dummy_courses.dart';
import 'hive_operations.dart';

/// The active Database is stored in _main.
/// Every CRUD operation is done twice. Once to main and once to the Hive box "courses".
class Database extends ChangeNotifier {
  final List<YearResult> _main = [];

  List<YearResult> get main => _main;

  Future<void> initialize([bool withDummyData = false]) async {
    // TODO: Implement Load with firestore

    await HiveOperations.init();

    if (withDummyData == true) {
      await addDummyData();
    } else {
      await loadDataFromLocalMemory();
    }

    HiveOperations.runTest();
  }

  loadDataFromLocalMemory() async {
    // TODO: Implement original order storage
    // Dump all the courses from memory to a Map<reference, CourseResult>
    Map<String, CourseResult> referencesToCourseResults =
        HiveOperations.loadMapOfReferenceToCourse();
    // To get the number of years
    int highestYearIndex = 0;
    for (String reference in referencesToCourseResults.keys) {
      int yearIndex = double.parse(reference.toString()[2]).toInt();
      if (yearIndex >= highestYearIndex) {
        highestYearIndex = yearIndex;
      }
    }
    // Creating the YearResult objects
    List<YearResult> yearResults = [];
    for (int yearIndex = 0; yearIndex <= highestYearIndex; yearIndex++) {
      YearResult yearResult = YearResult(year: yearIndex + 1);
      yearResults.add(yearResult);
    }
    // Distributing the courses to the year and semester they belong
    for (String reference in referencesToCourseResults.keys) {
      int yearIndex = double.parse(reference.toString()[2]).toInt();
      late bool isFirstSemester;
      switch (double.parse(reference.toString()[6]).toInt()) {
        case (1):
          isFirstSemester = true;
          break;
        case (2):
          isFirstSemester = false;
          break;
        default:
          throw Exception('The storage reference format is incorrect');
      }
      isFirstSemester == true
          ? yearResults[yearIndex]
              .addCourseToFirstSem(referencesToCourseResults[reference]!)
          : yearResults[yearIndex]
              .addCourseToSecondSem(referencesToCourseResults[reference]!);
    }
    // Adding the retrieved courses to _main
    _main.addAll([...yearResults]);
    notifyListeners(); // TODO: Maybe add initial loading incrementing animation. NotifyListeners after adding each course
  }

  addNewYear() {
    _main.add(YearResult(year: _main.length + 1));
    notifyListeners();
  }

  deleteLastYear() {
    _main.removeLast();
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

    await HiveOperations.editCourseInDatabase(
      newCourse: newCourse,
      yearResultIndex: yearResultIndex,
      isFirstSemester: isFirstSemester,
    );
    notifyListeners();
  }

  Future<void> deleteCourse({
    required int yearResultIndex,
    required bool isFirstSemester,
    required int courseResultIndex,
    required String courseToDeleteID,
  }) async {
    isFirstSemester == true
        ? _main[yearResultIndex].firstSem.removeCourse(courseResultIndex)
        : _main[yearResultIndex].secondSem.removeCourse(courseResultIndex);

    await HiveOperations.deleteCourseFromDatabase(
        courseUniqueID: courseToDeleteID,
        yearResultIndex: yearResultIndex,
        isFirstSemester: isFirstSemester);
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
