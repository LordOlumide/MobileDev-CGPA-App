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
                      Text(
                        'CGPA Calculator',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      userEmail != ''
                          ? Text(
                              userEmail,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
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
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
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

            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    for (int i = 0;
                        i < Provider.of<Database>(context).main.length;
                        i++)
                      YearCardDisplay(
                        yearResultIndex: i,
                        deleteThisYear: () {
                          Provider.of<Database>(context, listen: false)
                              .deleteLastYear();
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
                    fontWeight: FontWeight.w700,
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
