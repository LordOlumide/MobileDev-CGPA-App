import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';

class CourseInputSheet extends StatelessWidget {
  CourseInputSheet({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  String courseTitle = '';
  String courseDescription = '';
  String marks = '';
  String units = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InputField(
              fieldTitle: 'Course Title',
              fieldVariable: courseTitle,
              hint: 'e.g. GNS 101',
              textCapitalization: TextCapitalization.characters,
            ),

            // courseDescription
            InputField(
              fieldTitle: 'Course Name',
              fieldVariable: courseDescription,
              hint: 'e.g. History and Philosophy',
              textCapitalization: TextCapitalization.words,
            ),

            // marks
            InputField(
              fieldTitle: 'Score (%)',
              fieldVariable: marks,
              hint: 'e.g. 75',
              textCapitalization: TextCapitalization.none,
            ),

            // units
            InputField(
              fieldTitle: 'No. of Units',
              fieldVariable: units,
              hint: 'e.g. 2',
              textCapitalization: TextCapitalization.none,
            ),

            // "Add course" buttom
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.secondary),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
              ),
              child: Text(
                'Add Course',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
