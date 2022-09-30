import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/utils/number_to_position.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import '../../widgets/semester_card_display.dart';
import '../course_view_screen/course_view_screen.dart';

class SemesterScreen extends StatelessWidget {
  static const screenId = 'Semester screen';

  final int yearResultIndex;

  const SemesterScreen({Key? key, required this.yearResultIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    YearResult yearResult =
        Provider.of<Database>(context).main[yearResultIndex];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${noToPosition(yearResult.year)} Year',
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '${noToPosition(yearResult.year)} Year GPA: ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        yearResult.yearGPA.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SemesterCard(
                    yearResultIndex: yearResultIndex,
                    onPressed: () {
                      Navigator.pushNamed(context, CourseScreen.screenId,
                          arguments: {
                            'yearResultIndex': yearResultIndex,
                            'isFirstSemester': true,
                          });
                    },
                    isFirstSemester: true,
                  ),
                  const SizedBox(height: 30),
                  SemesterCard(
                    yearResultIndex: yearResultIndex,
                    onPressed: () {
                      Navigator.pushNamed(context, CourseScreen.screenId,
                          arguments: {
                            'yearResultIndex': yearResultIndex,
                            'isFirstSemester': false,
                          });
                    },
                    isFirstSemester: false,
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
