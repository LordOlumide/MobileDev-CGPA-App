import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/user_interface/widgets/delete_popup.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../screens/semester_view_screen/semester_view_screen.dart';

class YearCardDisplay extends StatelessWidget {
  final int yearResultIndex; // number of units
  final VoidCallback deleteThisYear;

  const YearCardDisplay({
    Key? key,
    required this.yearResultIndex,
    required this.deleteThisYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YearResult yearResult =
        Provider.of<Database>(context).main[yearResultIndex];

    return Container(
      margin: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: RawMaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, SemesterScreen.screenId,
              arguments: yearResultIndex);
        },
        fillColor: Theme.of(context).colorScheme.secondary,
        elevation: 3.0,
        padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    // The year: 1st year
                    Text(
                      '${noToPosition(yearResult.year)} year',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ],
                ),

                // Year GPA
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: 'GPA: '),
                        TextSpan(
                          text: yearResult.yearGPA.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        )
                      ],
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium!.color),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'First Semester:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\t\t\tCourses: ${yearResult.firstSem.totalNoOfCourses},'
                      '\t\tCourse Weight: ${yearResult.firstSem.totalNoOfUnits}',
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Second Semester:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '\t\t\tCourses: ${yearResult.secondSem.totalNoOfCourses},'
                      '\t\tCourse Weight: ${yearResult.secondSem.totalNoOfUnits}',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),

                // Delete button
                yearResult.isEmpty()
                    ? IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onPressed: () {
                          showDialog<bool>(
                            context: context,
                            builder: (context) => DeletePopup(
                                objectToDeleteName:
                                    'the current ${noToPosition(yearResult.year)} year'),
                          ).then((value) {
                            if (value == true) {
                              deleteThisYear();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 202, 54, 54),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
