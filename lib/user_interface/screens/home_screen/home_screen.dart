import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';
import 'package:provider/provider.dart';
import '../../widgets/year_card_display.dart';

class HomeScreen extends StatefulWidget {
  static const screenId = 'Home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                Text(
                  'Your CGPA: ${Provider.of<Database>(context).currentCGPA}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              for (int i = 0; i < Provider.of<Database>(context).main.length; i++)
                YearCardDisplay(yearResultIndex: i),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Provider.of<Database>(context, listen: false).addNewYear();
          });
          print('Added new year');
        },
      ),
    );
  }
}
