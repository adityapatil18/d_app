import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color containerColor;
  final List<Color> gradientColors; // List to store gradient colors

  CustomGradientButton({
    required this.onPressed,
    required this.buttonText,
    this.containerColor = Colors.transparent,
    required this.gradientColors, // Pass the gradient colors
  });

  @override
  Widget build(BuildContext context) {
    return CustomGradientContainer(
      containerColor: containerColor,
      gradientColors: gradientColors, // Pass gradient colors
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CustomGradientContainer extends StatelessWidget {
  final Color containerColor;
  final List<Color> gradientColors; // List to store gradient colors
  final Widget child;

  CustomGradientContainer({
    required this.containerColor,
    required this.gradientColors, // Pass gradient colors
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154.0,
      height: 53.0,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors, // Use gradient colors
        ),
      ),
      child: child,
    );
  }
}
