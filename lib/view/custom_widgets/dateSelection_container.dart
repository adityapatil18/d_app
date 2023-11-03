import 'package:d_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateSelectionContainer extends StatefulWidget {
  final Color textColor;
  final Color iconColor;

  CustomDateSelectionContainer({
    required this.textColor,
    required this.iconColor,
  });

  @override
  State<CustomDateSelectionContainer> createState() =>
      _CustomDateSelectionContainerState();
}

class _CustomDateSelectionContainerState
    extends State<CustomDateSelectionContainer> {
  String selectedDate = DateFormat('dd/MM/yy').format(DateTime.now());
  final TextStyle customTextStyle = TextStyle(
    color: MyAppColor.mainBlueColor, // Set the text color to #2C1BEF
    fontWeight: FontWeight.bold, // Customize the font weight
  );

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != DateTime.now()) {
  //     setState(() {
  //       selectedDate = DateFormat('dd/MM/yy').format(picked);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      width: 166,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Color(0xFFD9D9D9), Color(0xDEDEDEDE)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // setState(() {
              //   _selectDate(context);
              // });
            },
            child: Row(
              children: [
                Text(
                  selectedDate,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.calendar_month,
                  color: widget.iconColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
