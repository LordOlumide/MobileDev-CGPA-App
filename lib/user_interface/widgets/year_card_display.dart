import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/helpers/number_to_position.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(3),
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
