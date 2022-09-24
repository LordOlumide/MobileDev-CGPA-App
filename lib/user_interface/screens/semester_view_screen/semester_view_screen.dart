import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/helpers/number_to_position.dart';
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${noToPosition(yearResult.year)} Year',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SemesterCard(
                semesterResult: yearResult.firstSem,
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
                semesterResult: yearResult.secondSem,
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
    );
  }
}
