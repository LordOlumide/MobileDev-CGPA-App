import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/models/form_variables.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'course_input_sheet.dart';
import '../../widgets/course_card_display.dart';

class CourseScreen extends StatelessWidget {
  static const screenId = 'Course screen';
  final int yearResultIndex;
  final bool isFirstSemester;

  const CourseScreen({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SemesterResult semesterResult = isFirstSemester == true
        ? Provider.of<Database>(context).main[yearResultIndex].firstSem
        : Provider.of<Database>(context).main[yearResultIndex].secondSem;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              // Year
              Text(
                '${noToPosition(yearResultIndex + 1)} Year',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Semester
              Text(
                isFirstSemester == true
                    ? '1st Semester Courses:'
                    : '2nd Semester Courses:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    // Courses
                    for (int i = 0; i < semesterResult.courseResults.length; i++)
                      CourseCard(
                        yearResultIndex: yearResultIndex,
                        isFirstSemester: isFirstSemester,
                        courseResultIndex: i,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FormVariables variablesObject = FormVariables();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Provider(
                  create: (context) => variablesObject,
                  child: CourseInputSheet(),
                ),
              ),
            ),
          ).then((value) {
            CourseResult newCourse = variablesObject.toCourse();
            print(newCourse);
            if (value == true) {
              Provider.of<Database>(context, listen: false).addCourse(
                newCourse: newCourse,
                yearResultIndex: yearResultIndex,
                isFirstSemester: isFirstSemester,
              );
            } else {
              print('false');
            }
          });
        },
        tooltip: 'Add Course',
        child: const Icon(Icons.add),
      ),
    );
  }
}
