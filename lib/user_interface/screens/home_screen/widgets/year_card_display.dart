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
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
            ),
          ],
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              yearTitle,
              style: TextStyle(),
            ),
            Text(
              'GPA: $yearGPA',
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
