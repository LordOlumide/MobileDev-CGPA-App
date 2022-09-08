import 'package:flutter/material.dart';

class YearCardDisplay extends StatelessWidget {
  String yearTitle;
  int courseCount; // number of courses currently entered
  int courseUnits; // number of units
  int yearGPA;

  YearCardDisplay({
    Key? key,
    required this.yearTitle,
    required this.courseCount,
    required this.courseUnits,
    required this.yearGPA,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          yearTitle,
          style: TextStyle(),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(
                  'Courses: \n$courseCount',
                  style: TextStyle(),
                ),
                Text(
                  'Units: \n$courseUnits',
                  style: TextStyle(),
                ),
                Text(
                  'GPA: \n$yearGPA',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
