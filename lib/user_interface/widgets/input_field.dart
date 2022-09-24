import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/form_variables.dart';
import 'package:provider/provider.dart';

class InputField extends StatelessWidget {
  final bool isFirstField;
  final String fieldTitle;
  String fieldVariableName;
  final String hint;
  final TextCapitalization textCapitalization;
  final bool numInputExpected;

  InputField({
    Key? key,
    required this.isFirstField,
    required this.fieldTitle,
    required this.fieldVariableName,
    required this.hint,
    required this.textCapitalization,
    required this.numInputExpected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        TextFormField(
          autofocus: isFirstField,  // TODO: Fix the keyboard dropping issue
          onChanged: (newString) {
            Provider.of<FormVariables>(context, listen: false)
                .variables[fieldVariableName] = newString;
          },
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 2.0),
            ),
          ),
          textCapitalization: textCapitalization,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Course must have $fieldTitle';
            }
            if (numInputExpected == true && double.tryParse(value) == null) {
              return '$fieldTitle must be a number';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
