import 'package:mobile_dev_cgpa_app/models/course_result.dart';

class FormVariables {
  Map<String, String> variables = {
    'courseTitle': '',
    'courseDescription': '',
    'marks': '',
    'units': '',
  };

  CourseResult toCourse() {
    return CourseResult(
      courseTitle: variables['courseTitle']!,
      courseDescription: variables['courseDescription']!,
      marks: double.parse(variables['marks']!).toInt(),
      units: double.parse(variables['units']!).toInt(),
    );
  }

}
