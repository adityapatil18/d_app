import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constant.dart';
import '../custom_widgets/dateSelection_container.dart';
import '../custom_widgets/text_field.dart';
import '../custom_widgets/text_widget.dart';

class RecivedEntryScreen extends StatefulWidget {
  const RecivedEntryScreen({super.key});

  @override
  State<RecivedEntryScreen> createState() => _RecivedEntryScreenState();
}

class _RecivedEntryScreenState extends State<RecivedEntryScreen> {
  TextEditingController _receivedNameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Image.asset(
        'images/question.png',
        height: 30,
        width: 30,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextWidget(
                text: 'RECEIVED ENTRY',
                textcolor: MyAppColor.greenColor,
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
                      controller: _receivedNameController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ]),
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
                    controller: _amountController,
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
