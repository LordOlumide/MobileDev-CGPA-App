import 'package:flutter/material.dart';

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
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
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
        const SizedBox(height: 15),
      ],
    );
  }
}
