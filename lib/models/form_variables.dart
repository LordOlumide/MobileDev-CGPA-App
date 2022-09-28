import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class FormVariables {
  // TextEditingControllers
  late TextEditingController courseTitleController;
  late TextEditingController courseDescController;
  late TextEditingController marksController;
  late TextEditingController unitsController;

  initializeControllers() {
    courseTitleController = TextEditingController();
    courseDescController = TextEditingController();
    marksController = TextEditingController();
    unitsController = TextEditingController();
  }

  manuallyAssign({
    required String courseTitle,
    required String courseDesc,
    required String marks,
    required String units,
  }) {
    courseTitleController.text = courseTitle;
    courseDescController.text = courseDesc;
    marksController.text = marks;
    unitsController.text = units;
  }

  disposeControllers() {
    courseTitleController.dispose();
    courseDescController.dispose();
    marksController.dispose();
    unitsController.dispose();
  }

  resetControllers() {
    courseTitleController.clear();
    courseDescController.clear();
    marksController.clear();
    unitsController.clear();
  }

  CourseResult toCourse({String? uniqueID}) {
    return CourseResult(
      uniqueId: uniqueID,
      courseTitle: courseTitleController.text,
      courseDescription: courseDescController.text,
      marks: double.parse(marksController.text).toInt(),
      units: double.parse(unitsController.text).toInt(),
    );
  }

  @override
  String toString() {
    return 'title: ${courseTitleController.text}, desc: ${courseDescController.text}, '
        'marks: ${marksController.text}, units: ${unitsController.text}';
  }
}
