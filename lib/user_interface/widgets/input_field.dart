import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/constants/decorations.dart';

class InputField extends StatelessWidget {
  final bool isFirstField;
  final TextEditingController controller;
  final String fieldTitle;
  String fieldVariableName;
  final String hint;
  final TextCapitalization textCapitalization;
  final bool isMarksField;
  final bool isUnitsField;

  InputField({
    Key? key,
    required this.isFirstField,
    required this.controller,
    required this.fieldTitle,
    required this.fieldVariableName,
    required this.hint,
    required this.textCapitalization,
    required this.isMarksField,
    required this.isUnitsField,
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
          autofocus: isFirstField,
          initialValue: controller.text,
          onChanged: (newString) {
            controller.text = newString;
          },
          cursorColor: Colors.black87,
          decoration: kTextFieldDecoration.copyWith(
            hintText: hint,
          ),
          keyboardType: (isMarksField == true || isUnitsField == true)
              ? TextInputType.number : TextInputType.text,
          textCapitalization: textCapitalization,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Cannot be empty';
            }
            if ((isMarksField == true || isUnitsField == true)
                && double.tryParse(value) == null) {
              return 'Must be number';
            }
            if (isMarksField == true &&
                (double.parse(value) < 0 || double.parse(value) > 100)) {
              return '0 <= Score <= 100';
            }
            if (isUnitsField == true &&
                (double.parse(value) < 0 || double.parse(value) > 100)) {
              return 'Be reasonable';
            }
            return null;
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}
