import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final int yearResultIndex;
  final bool isFirstSemester;
  final int courseResultIndex;
  bool inSelectionMode;
  final VoidCallback onNormalModeTap;
  final VoidCallback onSelectionModeTap;
  final VoidCallback onLongPress;
  final VoidCallback deleteThisCourse;

  CourseCard({
    Key? key,
    required this.yearResultIndex,
    required this.isFirstSemester,
    required this.courseResultIndex,
    required this.inSelectionMode,
    required this.onNormalModeTap,
    required this.onSelectionModeTap,
    required this.deleteThisCourse,
    required this.onLongPress,
  }) : super(key: key);

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    CourseResult courseResult = widget.isFirstSemester == true
        ? Provider.of<Database>(context)
            .main[widget.yearResultIndex]
            .firstSem
            .courseResults[widget.courseResultIndex]
        : Provider.of<Database>(context)
            .main[widget.yearResultIndex]
            .secondSem
            .courseResults[widget.courseResultIndex];

    // bool inSelectionMode = Provider.of<bool>(context);
    bool isSelected =
        Provider.of<List<bool>>(context)[widget.courseResultIndex];

    return InkWell(
      onTap: () {
        if (widget.inSelectionMode == false) {
          widget.onNormalModeTap();
        } else {
          widget.onSelectionModeTap();
        }
      },
      onLongPress: () {
        widget.onLongPress();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 4, 10, 4),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course title
                  Text(
                    courseResult.courseTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 1),

                  // Course description
                  Text(
                    courseResult.courseDescription,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // Score
                      Text(
                        'Score: ${courseResult.marks}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // Grade
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          children: [
                            const TextSpan(text: 'Grade: '),
                            TextSpan(
                              text: courseResult.grade,
                              style: const TextStyle(
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
            widget.inSelectionMode
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (_) {
                        widget.onSelectionModeTap();
                      },
                    ),
                  )
                : const SizedBox(),
            // // Delete button
            // IconButton(
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   onPressed: () {
            //     showDialog<bool>(
            //       context: context,
            //       builder: (context) =>
            //           DeletePopup(objectToDeleteName: courseResult.courseTitle),
            //     ).then((value) {
            //       if (value == true) {
            //         widget.deleteThisCourse();
            //       }
            //     });
            //   },
            //   icon: const Icon(Icons.delete),
            // ),
          ],
        ),
      ),
    );
  }
}
