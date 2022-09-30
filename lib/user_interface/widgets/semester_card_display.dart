import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';

class SemesterCard extends StatelessWidget {
  final int yearResultIndex;
  final VoidCallback onPressed;
  final bool isFirstSemester;

  const SemesterCard({
    Key? key,
    required this.yearResultIndex,
    required this.onPressed,
    required this.isFirstSemester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SemesterResult semesterResult = isFirstSemester == true
        ? Provider.of<Database>(context).main[yearResultIndex].firstSem
        : Provider.of<Database>(context).main[yearResultIndex].secondSem;

    return Expanded(
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: isFirstSemester == true
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFirstSemester == true ? 'First Semester' : 'Second Semester',
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),

            // Semester GPA
            Text(
              'Semester GPA:  ${semesterResult.semesterGPA.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            // Number of Courses
            Text(
              'Number of Courses:  ${semesterResult.totalNoOfCourses}',
              style: const TextStyle(),
            ),
            const SizedBox(height: 5),

            // Number of Units
            Text(
              'Number of Units:  ${semesterResult.totalNoOfUnits}',
              style: const TextStyle(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
