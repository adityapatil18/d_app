import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import 'text_widget.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.imagePath,
      required this.text,
      required this.onTap,
      required this.borderRadius, required this.border
      });
  final String imagePath;
  final String text;
  final Function onTap;
  final BorderRadius borderRadius;
  final Border border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 131,
        height: 115,
        decoration: BoxDecoration(borderRadius: borderRadius,border: border),
        
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
