import 'package:flutter/material.dart';

class YSpace extends StatelessWidget {
  final double height;
  const YSpace(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
