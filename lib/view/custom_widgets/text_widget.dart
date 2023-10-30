import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      required this.textcolor,
      required this.textsize,
      required this.textweight});
  final String text;
  final Color textcolor;
  final double textsize;
  final FontWeight textweight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textcolor, fontSize: textsize, fontWeight: textweight),
    );
  }
}
