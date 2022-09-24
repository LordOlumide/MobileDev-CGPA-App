import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/helpers/number_to_position.dart';

class YearCardDisplay extends StatelessWidget {
  YearResult yearResult;// number of units

  YearCardDisplay({
    Key? key,
    required this.yearResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // The year: 1st year
                Text(
                  '${noToPosition(yearResult.year)} year',
                  style: TextStyle(),
                ),
              ],
            ),
            Text(
              'GPA: ${yearResult.yearGPA}',
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
