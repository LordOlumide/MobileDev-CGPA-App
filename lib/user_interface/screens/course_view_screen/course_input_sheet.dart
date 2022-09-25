import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';

class CourseInputSheet extends StatelessWidget {
  TextEditingController courseTitleController;
  TextEditingController courseDescriptionController;
  TextEditingController marksController;
  TextEditingController unitsController;

  CourseInputSheet({
    Key? key,
    required this.courseTitleController,
    required this.courseDescriptionController,
    required this.marksController,
    required this.unitsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Form(
        child: Column(
          children: [
            // course title
            InputField(
              isFirstField: true,
              controller: courseTitleController,
              fieldTitle: 'Course Title',
              fieldVariableName: 'courseTitle',
              hint: 'e.g. GNS 101',
              textCapitalization: TextCapitalization.characters,
              numInputExpected: false,
            ),

            // courseDescription
            InputField(
              isFirstField: false,
              controller: courseDescriptionController,
              fieldTitle: 'Course Name',
              fieldVariableName: 'courseDescription',
              hint: 'e.g. History and Philosophy',
              textCapitalization: TextCapitalization.words,
              numInputExpected: false,
            ),

            Row(
              children: [
                // marks
                Expanded(
                  child: InputField(
                    isFirstField: false,
                    controller: marksController,
                    fieldTitle: 'Score (%)',
                    fieldVariableName: 'marks',
                    hint: 'e.g. 75',
                    textCapitalization: TextCapitalization.none,
                    numInputExpected: true,
                  ),
                ),
                const SizedBox(width: 30),

                // units
                Expanded(
                  child: InputField(
                    isFirstField: false,
                    controller: unitsController,
                    fieldTitle: 'No. of Units',
                    fieldVariableName: 'units',
                    hint: 'e.g. 2',
                    textCapitalization: TextCapitalization.none,
                    numInputExpected: true,
                  ),
                ),
              ],
            ),

            // "Add course" button
            Builder(
              builder: (context) {
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
                    'Add Course',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 17,
                    ),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
