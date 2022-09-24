import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/input_field.dart';
import 'package:mobile_dev_cgpa_app/models/form_variables.dart';

class CourseInputSheet extends StatelessWidget {
  CourseInputSheet({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
              fieldVariableName: 'courseTitle',
              hint: 'e.g. GNS 101',
              textCapitalization: TextCapitalization.characters,
            ),

            // courseDescription
            InputField(
              fieldTitle: 'Course Name',
              fieldVariableName: 'courseDescription',
              hint: 'e.g. History and Philosophy',
              textCapitalization: TextCapitalization.words,
            ),

            // marks
            InputField(
              fieldTitle: 'Score (%)',
              fieldVariableName: 'marks',
              hint: 'e.g. 75',
              textCapitalization: TextCapitalization.none,
            ),

            // units
            InputField(
              fieldTitle: 'No. of Units',
              fieldVariableName: 'units',
              hint: 'e.g. 2',
              textCapitalization: TextCapitalization.none,
            ),

            // "Add course" button
            ElevatedButton(
              onPressed: () {
                FormVariables variablesObject
                    = Provider.of<FormVariables>(context, listen: false);

                if (_formKey.currentState!.validate()) {
                  print('${variablesObject.variables['courseTitle']!},'
                      ' ${variablesObject.variables['courseDescription']!}, '
                      '${variablesObject.variables['marks']!},'
                      ' ${variablesObject.variables['units']!}');
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
            ),
          ],
        ),
      ),
    );
  }
}
