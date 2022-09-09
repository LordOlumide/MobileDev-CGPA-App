import 'package:flutter/material.dart';

class YearCardDisplay extends StatelessWidget {
  String yearTitle;// number of units
  double? yearGPA;

  YearCardDisplay({
    Key? key,
    required this.yearTitle,
    this.yearGPA,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
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
                    'GPA: \n$yearGPA',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
