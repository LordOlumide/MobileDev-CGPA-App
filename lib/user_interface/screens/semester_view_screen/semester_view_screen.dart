import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import '../../widgets/semester_card_display.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SemesterCard(
              semesterResult: yearResult.firstSem,
              onPressed: () {},
              isFirstSemester: true,
            ),
            const SizedBox(height: 20),
            SemesterCard(
              semesterResult: yearResult.secondSem,
              onPressed: () {},
              isFirstSemester: false,
            ),
          ],
        ),
      ),
    );
  }
}
