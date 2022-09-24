import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';

class SemesterCard extends StatelessWidget {
  SemesterResult semesterResult;
  VoidCallback onPressed;
  bool isFirstSemester;

  SemesterCard({
    Key? key,
    required this.semesterResult,
    required this.onPressed,
    required this.isFirstSemester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            isFirstSemester == true ? 'First Semester' : 'Second Semester',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          Text(
            'Semester GPA: ${semesterResult.semesterGPA}',
            style: TextStyle(),
          ),
          FittedBox(
            child: Column(
              children: [
                for (CourseResult courseResult
                    in semesterResult.courseResults)
                  Text(
                    '${courseResult.courseTitle} :   ${courseResult.grade}',
                    style: TextStyle(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
