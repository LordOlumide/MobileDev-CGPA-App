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
  @override
  void initState() {
    super.initState();
    formVariables.initializeControllers();
    refreshStatesList();
  }

  /// This stores the input from the course_input_sheet temporarily to be converted to a Course object.
  FormVariables formVariables = FormVariables();

  bool inSelectionMode = false;

  // To store the isSelected states of every course in the semesterResult.
  List<bool> courseCardStates = [];

  void refreshStatesList() {
    courseCardStates.clear();
    SemesterResult semesterResult = widget.isFirstSemester == true
        ? Provider.of<Database>(context, listen: false)
            .main[widget.yearResultIndex]
            .firstSem
        : Provider.of<Database>(context, listen: false)
            .main[widget.yearResultIndex]
            .secondSem;
    for (int i = 0; i < semesterResult.courseResults.length; i++) {
      courseCardStates.add(false);
    }
  }

  void toggleState({required int index}) {
    setState(() {
      courseCardStates[index] = !courseCardStates[index];
    });
  }

  deactivateInSelectionState() {
    setState(() {
      inSelectionMode = false;
    });
    refreshStatesList();
  }

  activateInSelectionState(int activatingCourseIndex) {
    setState(() {
      inSelectionMode = true;
    });
    toggleState(index: activatingCourseIndex);
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

    void addNewCourse() {
      CourseResult newCourse = formVariables.toCourse();
      Provider.of<Database>(context, listen: false).addCourse(
        newCourse: newCourse,
        yearResultIndex: widget.yearResultIndex,
        isFirstSemester: widget.isFirstSemester,
      );
      refreshStatesList();
    }

    void editCourse({required int courseResultIndex}) {
      String courseToBeReplacedID =
          semesterResult.courseResults[courseResultIndex].uniqueId!;
      CourseResult newCourse =
          formVariables.toCourse(uniqueID: courseToBeReplacedID);

      Provider.of<Database>(context, listen: false).editCourse(
        newCourse: newCourse,
        yearResultIndex: widget.yearResultIndex,
        isFirstSemester: widget.isFirstSemester,
        courseResultIndex: courseResultIndex,
      );
      refreshStatesList();
    }

    void deleteCourse({required int courseResultIndex}) {
      String courseToDeleteID =
          semesterResult.courseResults[courseResultIndex].uniqueId!;
      Provider.of<Database>(context, listen: false).deleteCourse(
        yearResultIndex: widget.yearResultIndex,
        isFirstSemester: widget.isFirstSemester,
        courseResultIndex: courseResultIndex,
        courseToDeleteID: courseToDeleteID,
      );
      refreshStatesList();
    }

    /// bool addNotEdit is true when this function is called to add a new course
    /// and false when it's called to edit an existing course.
    bringUpBottomSheet(
        {required bool addNotEdit, required VoidCallback onFormSubmitted}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Provider(
              create: (context) => formVariables,
              child: CourseInputSheet(
                addNotEdit: addNotEdit,
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
          onFormSubmitted();
        }
        // Reset the controllers after the screen is dismissed
        formVariables.resetControllers();
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (inSelectionMode == true) {
          deactivateInSelectionState();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 1,
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.fromLTRB(30, 25, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Year
                      Text(
                        '${noToPosition(widget.yearResultIndex + 1)} Year',
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        widget.isFirstSemester == true
                            ? '1st Semester'
                            : '2nd Semester',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Semester GPA: ${semesterResult.semesterGPA.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Courses:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Courses
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 20),
                        itemCount: semesterResult.courseResults.length,
                        itemBuilder: (context, courseIndex) {
                          return Provider(
                            create: (context) => courseCardStates,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: CourseCard(
                                  yearResultIndex: widget.yearResultIndex,
                                  isFirstSemester: widget.isFirstSemester,
                                  courseResultIndex: courseIndex,
                                  inSelectionMode: inSelectionMode,
                                  isSelected: courseCardStates[courseIndex],
                                  onNormalModeTap: () {
                                    // set the controller values to the course values
                                    CourseResult initialCourseResult =
                                        semesterResult
                                            .courseResults[courseIndex];
                                    formVariables.manuallyAssign(
                                      courseTitle:
                                          initialCourseResult.courseTitle,
                                      courseDesc:
                                          initialCourseResult.courseDescription,
                                      marks: '${initialCourseResult.marks}',
                                      units: '${initialCourseResult.units}',
                                    );
                                    bringUpBottomSheet(
                                      addNotEdit: false,
                                      onFormSubmitted: () {
                                        editCourse(
                                            courseResultIndex: courseIndex);
                                      },
                                    );
                                  },
                                  onSelectionModeTap: () {
                                    toggleState(index: courseIndex);
                                  },
                                  onLongPress: (int activatingCourseIndex) {
                                    if (inSelectionMode == false) {
                                      activateInSelectionState(
                                          activatingCourseIndex);
                                    }
                                  }),
                            ),
                          );
                        },
                      ),
                    ),

                    const Divider(
                      height: 1.2,
                      thickness: 1.2,
                      color: Color.fromARGB(95, 136, 136, 136),
                    ),
                    inSelectionMode
                        ? Container(
                            height: 60,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Center(
                              child: IconButton(
                                padding: const EdgeInsets.all(3),
                                onPressed: () {},
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                iconSize: 25,
                                icon: Column(
                                  children: [
                                    const Icon(Icons.delete_outline),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: inSelectionMode == false
            ? FloatingActionButton(
                onPressed: () {
                  bringUpBottomSheet(
                    addNotEdit: true,
                    onFormSubmitted: () {
                      addNewCourse();
                    },
                  );
                },
                tooltip: 'Add Course',
                child: const Icon(Icons.add),
              )
            : const SizedBox(),
      ),
    );
  }
}
