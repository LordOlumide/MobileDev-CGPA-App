import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../../widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  final String userEmail;

  const HomeScreen({Key? key, this.userEmail = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Material(
                elevation: 2,
                child: Container(
                  color: Theme.of(context).colorScheme.primary,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                          children: [
                            const TextSpan(text: 'Your CGPA: '),
                            TextSpan(
                              text: Provider.of<Database>(context)
                                  .currentCGPA
                                  .toStringAsFixed(2),
                              style: const TextStyle(
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
              ),
            ),

            // The years ListView  TODO: Implement deleteYearFromDatabase()
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: ListView(
                  children: [
                    for (int i = 0;
                        i < Provider.of<Database>(context).main.length;
                        i++)
                      YearCardDisplay(
                        yearResultIndex: i,
                        deleteThisYear: () {
                          Provider.of<Database>(context, listen: false)
                              .deleteYear(yearResultIndex: i);
                        },
                      ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1.5,
              thickness: 1.5,
              color: Colors.black54,
            ),

            // "Add New Year" button
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
