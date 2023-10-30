import 'package:d_app/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomDateSelectionContainer extends StatelessWidget {
  final String selectedDate;
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final Color iconColor;

  CustomDateSelectionContainer({
    required this.selectedDate,
    required this.containerColor,
    required this.textColor,
    required this.onTap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: 166,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [containerColor, containerColor.withOpacity(0.87)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  selectedDate,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.calendar_month,
                  color: iconColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
