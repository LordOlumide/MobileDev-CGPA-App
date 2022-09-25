import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/models/form_variables.dart';
import 'package:mobile_dev_cgpa_app/models/semester_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'course_input_sheet.dart';
import '../../widgets/course_card_display.dart';

class CourseScreen extends StatefulWidget {
  static const screenId = 'Course screen';
  final int yearResultIndex;
  final bool isFirstSemester;

  const CourseScreen({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
  }) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  FormVariables formVariables = FormVariables();

  @override
  void initState() {
    super.initState();
    formVariables.initializeControllers();
  }

  @override
  void dispose() {
    formVariables.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SemesterResult semesterResult = widget.isFirstSemester == true
        ? Provider.of<Database>(context).main[widget.yearResultIndex].firstSem
        : Provider.of<Database>(context).main[widget.yearResultIndex].secondSem;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              // Year
              Text(
                '${noToPosition(widget.yearResultIndex + 1)} Year',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Semester
              Text(
                widget.isFirstSemester == true
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
                    for (int i = 0;
                        i < semesterResult.courseResults.length;
                        i++)
                      CourseCard(
                        yearResultIndex: widget.yearResultIndex,
                        isFirstSemester: widget.isFirstSemester,
                        courseResultIndex: i,
                        onTapped: () {},// TODO: Implement onTapped
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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Provider(
                  create: (context) => formVariables,
                  child: CourseInputSheet(
                    courseTitleController: formVariables.courseTitleController,
                    courseDescriptionController: formVariables.courseDescController,
                    marksController: formVariables.marksController,
                    unitsController: formVariables.unitsController,
                  ),
                ),
              ),
            ),
          ).then((value) {
            if (value == true) {
              CourseResult newCourse = formVariables.toCourse();
              Provider.of<Database>(context, listen: false).addCourse(
                newCourse: newCourse,
                yearResultIndex: widget.yearResultIndex,
                isFirstSemester: widget.isFirstSemester,
              );
            }
            print(formVariables.toString());
            // Reset the controllers after the screen is dismissed
            formVariables.resetControllers();
          });
        },
        tooltip: 'Add Course',
        child: const Icon(Icons.add),
      ),
    );
  }
}
