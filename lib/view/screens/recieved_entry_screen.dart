import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../model/recived_entry_model.dart';
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
  TextEditingController _receivedFirstNameController = TextEditingController();
  TextEditingController _receivedLastNameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _searchNameController = TextEditingController();
  String _selectedOption = "";

  Future<REntry> createEntry(
      String firstName, String lastName, String amount) async {
    final response = await http.post(
      Uri.parse('https://appapi.techgigs.in/api/transaction/transfer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "amount": amount,
        "type": "credit",
        "status": "1",
        "Id": "",
      }),
    );
    print('api response:${response.body}');
    if (response.statusCode == 200) {
      return REntry.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create entry.');
    }
  }

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
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: "New Entry",
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text(
                      'New Entry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF202020)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: "Old Entry",
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        setState(() {
                          _selectedOption = value!;
                        });
                      },
                    ),
                    Text(
                      'Old Entry',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF202020)),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: _selectedOption == "New Entry",
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: 'First name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter First Name',
                                  controller: _receivedFirstNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                  text: 'Last name',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              CustomTextField(
                                  hintText: 'Enter Last Name',
                                  controller: _receivedLastNameController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter
                                        .singleLineFormatter
                                  ]),
                              SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                  text: 'Amount',
                                  textcolor: MyAppColor.textClor,
                                  textsize: 14,
                                  textweight: FontWeight.w600),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _amountController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Amount',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _selectedOption == "Old Entry",
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: _searchNameController,
                        onSubmitted: (value) {
                          setState(() {
                          });
                        },
                        keyboardType: TextInputType.name,
                        style: new TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_sharp),
                          border: InputBorder.none,
                          hintText: "Search by name",
                          hintStyle: new TextStyle(
                            color: Colors.black.withOpacity(0.54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                        text: 'Amount',
                        textcolor: MyAppColor.textClor,
                        textsize: 14,
                        textweight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                          hintText: 'Enter Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
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
        onTap: () {
          // setState(() {
          //   createEntry(_receivedFirstNameController.text,
          //       _receivedLastNameController.text, _amountController.text);
          // });
          final firstName = _receivedFirstNameController.text;
          final lastName = _receivedLastNameController.text;
          final amount = _amountController.text;

          // Check if required fields are not empty
          if (firstName.isNotEmpty &&
              lastName.isNotEmpty &&
              amount.isNotEmpty) {
            // You can set the "status" based on the selected option here
            String status;
            if (_selectedOption == "New Entry") {
              status = "1";
            } else if (_selectedOption == "Old Entry") {
              status = "0";
            } else {
              // Provide a default value if no valid option is selected
              status = "0";
            }

            // Call the createEntry function to post the data
            createEntry(
              firstName,
              lastName,
              amount,
            );
          } else {
            // Show an error message if any of the required fields are empty
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please fill in all required fields.')),
            );
          }
        },
      ),
    );
  }
}
