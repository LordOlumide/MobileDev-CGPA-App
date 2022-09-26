import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:mobile_dev_cgpa_app/user_interface/widgets/delete_popup.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final int yearResultIndex;
  final bool isFirstSemester;
  final int courseResultIndex;
  final VoidCallback onTapped;
  final VoidCallback deleteThisCourse;

  const CourseCard({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
    required this.courseResultIndex,
    required this.onTapped,
    required this.deleteThisCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseResult courseResult = isFirstSemester == true
        ? Provider.of<Database>(context)
            .main[yearResultIndex]
            .firstSem
            .courseResults[courseResultIndex]
        : Provider.of<Database>(context)
            .main[yearResultIndex]
            .secondSem
            .courseResults[courseResultIndex];

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTapped,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 4, 10, 4),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course title
                  Text(
                    courseResult.courseTitle,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 1),

                  // Course description
                  Text(
                    courseResult.courseDescription,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Units
                      Text(
                        'Units: ${courseResult.units}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // Score
                      Text(
                        'Score: ${courseResult.marks}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // Grade
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          children: [
                            const TextSpan(text: 'Grade: '),
                            TextSpan(
                              text: courseResult.grade,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Delete button
        IconButton(
          padding: const EdgeInsets.symmetric(vertical: 4),
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (context) =>
                  DeletePopup(objectToDeleteName: courseResult.courseTitle),
            ).then((value) {
              if (value == true) {
                deleteThisCourse();
              }
            });
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
