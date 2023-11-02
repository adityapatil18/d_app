import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constant.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_field.dart';
import '../custom_widgets/text_widget.dart';

class GivenEntryScreen extends StatefulWidget {
  const GivenEntryScreen({super.key});

  @override
  State<GivenEntryScreen> createState() => _GivenEntryScreenState();
}

class _GivenEntryScreenState extends State<GivenEntryScreen> {
  TextEditingController _givenNameController = TextEditingController();
  TextEditingController _givenAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Image.asset(
        'images/question.png',
        height: 30,
        width: 30,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          TextWidget(
              text: 'GIVEN ENTRY',
              textcolor: MyAppColor.redColor,
              textsize: 22,
              textweight: FontWeight.w700),
          SizedBox(
            height: 20,
          ),
          CustomDateSelectionContainer(
              textColor: MyAppColor.grey3Color,
              iconColor: MyAppColor.grey3Color),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                    text: 'Name of  Person',
                    textcolor: MyAppColor.textClor,
                    textsize: 14,
                    textweight: FontWeight.w600),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Enter Name',
                  controller: _givenNameController,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                    text: 'Amount',
                    textcolor: MyAppColor.textClor,
                    textsize: 14,
                    textweight: FontWeight.w600),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Enter Amount',
                  controller: _givenAmountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CommaSeparatorInputFormatter(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 70,
        width: MediaQuery.sizeOf(context).width,
        color: MyAppColor.mainBlueColor,
        child: TextWidget(
            text: 'Add Entry',
            textcolor: Colors.white,
            textsize: 16,
            textweight: FontWeight.w600),
      ),
    );
  }
}
