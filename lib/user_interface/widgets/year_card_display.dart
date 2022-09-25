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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, SemesterScreen.screenId,
              arguments: yearResultIndex);
        },
        fillColor: Theme.of(context).colorScheme.secondary,
        elevation: 3.0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
