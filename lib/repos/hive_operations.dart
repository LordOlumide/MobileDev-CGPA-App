import 'package:hive/hive.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/utils/reference_getter.dart';

/// Box "courses" for storing the CourseItems
///
/// Storage reference format
///   = "Y-$YearResultIndex - S-${isFirstSemester ? 1 : 2} - C-${courseResult.uniqueId}"
/// Example: "Y-0 S-2 C-XXXXXXXXXXXXXXXXX" refers to a course in 1st year, 2nd semester
class HiveOperations {
  static late Box coursesBox;

  static Future<void> init() async {
    coursesBox = await Hive.openBox('courses');
  }

  static Map<String, CourseResult> loadMapOfReferenceToCourse() {
    Map<String, CourseResult> referencesToCourseResults = {};
    for (dynamic reference in coursesBox.keys) {
      referencesToCourseResults[reference.toString()] =
          coursesBox.get(reference) as CourseResult;
    }
    return referencesToCourseResults;
  }

  static Future<void> addCourseToLocalDatabase({
    required int yearResultIndex,
    required bool isFirstSemester,
    required CourseResult newCourse,
  }) async {
    String courseReference = getReference(
        yearResultIndex: yearResultIndex,
        isFirstSemester: isFirstSemester,
        courseUniqueID: newCourse.uniqueId!);

    await coursesBox.put(courseReference, newCourse);
  }

  static Future<void> editCourseInDatabase({
    required CourseResult newCourse,
    required int yearResultIndex,
    required bool isFirstSemester,
  }) async {
    String courseReference = getReference(
        yearResultIndex: yearResultIndex,
        isFirstSemester: isFirstSemester,
        courseUniqueID: newCourse.uniqueId!);
    coursesBox.put(courseReference, newCourse);
  }

  static Future<void> deleteCourseFromDatabase({
    required int yearResultIndex,
    required bool isFirstSemester,
    required String courseUniqueID,
  }) async {
    String courseReference = getReference(
        yearResultIndex: yearResultIndex,
        isFirstSemester: isFirstSemester,
        courseUniqueID: courseUniqueID);
    coursesBox.delete(courseReference);
  }

  static Future<void> clearPreviousCourses() async {
    await coursesBox.clear();
  }

  static void runTest() {
    final List<String> referencesList = [];
    for (dynamic i in coursesBox.keys) {
      referencesList.add('\n${i.toString()}');
    }
    print('\nNo of courses in Database: ${referencesList.length}');
    // print(referencesList);
  }
}
