import 'package:flutter/material.dart';
import 'widgets/year_card_display.dart';

class HomeScreen extends StatelessWidget {
  static const screenId = 'Home screen';

  HomeScreen({Key? key}) : super(key: key);

  List<String> strings = ['hi', 'lo', 'kids'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 40, 0, 10),
            child: const Text(
              'CGPA Calculator',
              style: TextStyle(),
            ),
          ),
          ...strings.map((e) => ListTile(title: Text(e))).toList(),
          ExpansionTile(
            title: Text('title'),
            children: strings.map((e) => ListTile(title: Text(e))).toList(),
          ),
        ],
      ),
    );
  }
}
