import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/repos/auth_repo.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../../widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  final String userEmail;

  HomeScreen({Key? key, this.userEmail = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 30, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'CGPA Calculator',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 7),
                  userEmail != ''
                      ? Text(
                          userEmail,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 7),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      children: [
                        const TextSpan(text: 'Your CGPA: '),
                        TextSpan(
                          text: Provider.of<Database>(context)
                              .currentCGPA
                              .toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // The years ListView
            Expanded(
              child: ListView(
                children: [
                  for (int i = 0;
                      i < Provider.of<Database>(context).main.length;
                      i++)
                    YearCardDisplay(yearResultIndex: i),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // "Add New Year" button
            ElevatedButton(
              onPressed: () {
                Provider.of<Database>(context, listen: false).addNewYear();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor!),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              child: Text(
                'Add New Year',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
