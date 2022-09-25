import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../../widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 40, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CGPA Calculator',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15),
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
                        text: Provider.of<Database>(context).currentCGPA.toStringAsFixed(2),
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
          Column(
            children: [
              for (int i = 0;
                  i < Provider.of<Database>(context).main.length;
                  i++)
                YearCardDisplay(yearResultIndex: i),
              const SizedBox(height: 30),

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
        ],
      ),
    );
  }
}
