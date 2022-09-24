import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String fieldTitle;
  String fieldVariable;
  final String hint;
  final TextCapitalization textCapitalization;

  InputField({
    Key? key,
    required this.fieldTitle,
    required this.fieldVariable,
    required this.hint,
    required this.textCapitalization,
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
          autofocus: true,
          onChanged: (newString) {
            fieldVariable = newString;
          },
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 1.0),
              // borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 2.0),
              // borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
          textCapitalization: textCapitalization,
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Course must have $fieldTitle';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
