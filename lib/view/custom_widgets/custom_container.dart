import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import 'text_widget.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.onTap});
  final String imagePath;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 131,
        height: 115,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              height: 90,
              width: 90,
            ),
            TextWidget(
                text: text,
                textcolor: MyAppColor.textClor,
                textsize: 14,
                textweight: FontWeight.w600)
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
