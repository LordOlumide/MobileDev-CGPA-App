import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';

class SemesterScreen extends StatelessWidget {
  final YearResult yearResult;
  const SemesterScreen({Key? key, required this.yearResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
