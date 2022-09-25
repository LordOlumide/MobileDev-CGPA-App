import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../screens/semester_view_screen/semester_view_screen.dart';

class YearCardDisplay extends StatelessWidget {
  int yearResultIndex; // number of units

  YearCardDisplay({
    Key? key,
    required this.yearResultIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YearResult yearResult =
        Provider.of<Database>(context).main[yearResultIndex];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SemesterScreen.screenId,
            arguments: yearResultIndex);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                // The year: 1st year
                Text(
                  '${noToPosition(yearResult.year)} year',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),

            // Year GPA
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'GPA: '),
                  TextSpan(
                    text: yearResult.yearGPA.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  )
                ],
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
