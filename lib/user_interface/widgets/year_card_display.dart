import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/user_interface/widgets/delete_popup.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../screens/semester_view_screen/semester_view_screen.dart';

class YearCardDisplay extends StatelessWidget {
  int yearResultIndex; // number of units
  final VoidCallback deleteThisYear;

  YearCardDisplay({
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
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, SemesterScreen.screenId,
                    arguments: yearResultIndex);
              },
              fillColor: Theme.of(context).colorScheme.secondary,
              elevation: 3.0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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

                  const Text(
                    'First Semester:',
                    style: TextStyle(),
                  ),
                  Text(
                        '\t\tCourses: ${yearResult.firstSem.totalNoOfCourses}'
                        '\t\tCourse Weight: ${yearResult.firstSem.totalNoOfUnits}',
                    style: const TextStyle(),
                  ),
                  const SizedBox(height: 3),

                  const Text(
                    'Second Semester:',
                    style: TextStyle(),
                  ),
                  Text(
                        '\t\tCourses: ${yearResult.secondSem.totalNoOfCourses}'
                        '\t\tCourse Weight: ${yearResult.secondSem.totalNoOfUnits}',
                    style: const TextStyle(),
                  ),
                ],
              ),
            ),
          ),

          // Delete button
          IconButton(
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (context) =>
                    DeletePopup(objectToDeleteName: '${noToPosition(yearResult.year)} year'),
              ).then((value) {
                if (value == true) {
                  deleteThisYear();
                }
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
