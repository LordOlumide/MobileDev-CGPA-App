import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';

class CourseInputSheet extends StatelessWidget {
  final bool addNotEdit;
  final TextEditingController courseTitleController;
  final TextEditingController courseDescriptionController;
  final TextEditingController marksController;
  final TextEditingController unitsController;

  const CourseInputSheet({
    Key? key,
    required this.addNotEdit,
    required this.courseTitleController,
    required this.courseDescriptionController,
    required this.marksController,
    required this.unitsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Form(
        child: Column(
          children: [
            // Header
            Text(
              addNotEdit ? 'Add New Course' : 'Edit Course',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),

            // course title
            InputField(
              isFirstField: true,
              controller: courseTitleController,
              fieldTitle: 'Course Title',
              hint: 'e.g. GNS 101',
              textCapitalization: TextCapitalization.characters,
              isMarksField: false,
              isUnitsField: false,
            ),

            // courseDescription
            InputField(
              isFirstField: false,
              controller: courseDescriptionController,
              fieldTitle: 'Course Name',
              hint: 'e.g. History and Philosophy',
              textCapitalization: TextCapitalization.words,
              isMarksField: false,
              isUnitsField: false,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // marks
                Expanded(
                  child: InputField(
                    isFirstField: false,
                    controller: marksController,
                    fieldTitle: 'Score (%)',
                    hint: 'e.g. 75',
                    textCapitalization: TextCapitalization.none,
                    isMarksField: true,
                    isUnitsField: false,
                  ),
                ),
                const SizedBox(width: 30),

                // units
                Expanded(
                  child: InputField(
                    isFirstField: false,
                    controller: unitsController,
                    fieldTitle: 'No. of Units',
                    hint: 'e.g. 2',
                    textCapitalization: TextCapitalization.none,
                    isMarksField: false,
                    isUnitsField: true,
                  ),
                ),
              ],
            ),

            // "Add course" button
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  if (Form.of(context)!.validate()) {
                    Navigator.pop(context, true);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5)),
                ),
                child: Text(
                  addNotEdit ? 'Add Course' : 'Save Edit',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 17,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
