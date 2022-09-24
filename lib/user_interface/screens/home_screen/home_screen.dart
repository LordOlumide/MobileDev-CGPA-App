import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_dev_cgpa_app/models/year_result.dart';
import 'package:mobile_dev_cgpa_app/repos/data_repo.dart';
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
            child: const Text(
              'CGPA Calculator',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              for (YearResult result in Provider.of<DataRepo>(context).main)
                YearCardDisplay(yearResult: result),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Provider.of<DataRepo>(context, listen: false).addNewYear();
          print('Added new year');
        },
      ),
    );
  }
}
