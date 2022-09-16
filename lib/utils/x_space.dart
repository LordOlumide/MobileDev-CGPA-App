import 'package:flutter/material.dart';

class XSpace extends StatelessWidget {
  final double width;
  const XSpace(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
