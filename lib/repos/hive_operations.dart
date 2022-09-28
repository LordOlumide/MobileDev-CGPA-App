import 'package:hive/hive.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/utils/reference_getter.dart';

/// Box "courses" for storing the CourseItems
///
/// Storage reference format
///   = "Y-$YearResultIndex - S-${isFirstSemester ? 1 : 2} - C-${courseResult.uniqueId}"
/// Example: "Y2S2C4"

// TODO: store the number of years

class HiveOperations {
  static Future loadData() async {
    final coursesBox = await Hive.openBox('courses');
    final indexesList = coursesBox.keys as List<String>;

    List<CourseResult> courseResults = [];
    for (String key in indexesList) {
      CourseResult course = coursesBox.get(key);
      courseResults.add(course);
    }

    await coursesBox.close();
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

    final coursesBox = await Hive.openBox('courses');
    await coursesBox.put(courseReference, newCourse);
    await coursesBox.close();
  }

  static Future<void> editCourseInDatabase() async {}

  static Future<void> deleteCourseFromDatabase() async {}

  static Future<void> clearPreviousCourses() async {
    final coursesBox = await Hive.openBox('courses');
    print('Currently here');
    final x = await coursesBox.clear();
    print('there');
    print(x);
    await coursesBox.close();
    print('Complete');
  }

  static Future<void> runTest() async {
    final coursesBox = await Hive.openBox('courses');
    final List<String> indexesList = [];
    for (dynamic i in coursesBox.keys) {
      indexesList.add('\n${i.toString()}');
    }
    print('No of courses in Database: ${indexesList.length}');
    print(indexesList);

    await coursesBox.close();
  }
}
